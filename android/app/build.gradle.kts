import java.net.URI
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing: android/key.properties (never committed) with storeFile, storePassword,
// keyAlias, keyPassword. See flutter_app/README.md.
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}
val hasReleaseKeystore = keystoreProperties.getProperty("storeFile") != null

android {
    namespace = "com.eduplatform.student_app"
    compileSdk = flutter.compileSdkVersion
    // NDK: `edu.ndkVersion` in ../gradle.properties (also applied to plugins, see ../build.gradle.kts).
    ndkVersion = (project.findProperty("edu.ndkVersion") as String?) ?: flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.eduplatform.student_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKeystore) {
            create("release") {
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // Without key.properties the release build is signed with the debug key so it can be
            // installed for testing; store uploads require the real release key.
            signingConfig = signingConfigs.getByName(if (hasReleaseKeystore) "release" else "debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

// API_BASE_URL from ../../.env, the configuration file bundled into the app.
val apiUri: URI? = run {
    val envFile = rootProject.file("../.env")
    if (!envFile.exists()) return@run null
    val url = envFile.readLines()
        .map { it.trim() }
        .firstOrNull { it.startsWith("API_BASE_URL=") }
        ?.substringAfter("=")
        ?.trim()
        ?.trim('"', '\'')
        ?: return@run null
    runCatching { URI(url) }.getOrNull()?.takeIf { it.host != null }
}

// ─── Release builds: HTTPS only, except the API when .env gives an http:// address ───
// Generates res/xml/network_security_config.xml for non-debug builds: plain HTTP is allowed only
// to that API host (e.g. the server's IP before it has a domain with HTTPS) and to 127.0.0.1 (the
// in-app server that feeds downloaded, still encrypted, videos to the player). With an https://
// API only the loopback exception remains. Debug builds use src/debug/res/xml instead.
abstract class EduNetworkSecurityConfig : DefaultTask() {
    @get:Input
    abstract val cleartextHosts: ListProperty<String>

    @get:OutputDirectory
    abstract val outputDir: DirectoryProperty

    @TaskAction
    fun write() {
        val domains = cleartextHosts.get().joinToString("\n") {
            "        <domain includeSubdomains=\"false\">$it</domain>"
        }
        val file = outputDir.file("xml/network_security_config.xml").get().asFile
        file.parentFile.mkdirs()
        file.writeText(
            """
            |<?xml version="1.0" encoding="utf-8"?>
            |<!-- Generated from API_BASE_URL in .env by android/app/build.gradle.kts. -->
            |<network-security-config>
            |    <base-config cleartextTrafficPermitted="false">
            |        <trust-anchors>
            |            <certificates src="system" />
            |        </trust-anchors>
            |    </base-config>
            |    <domain-config cleartextTrafficPermitted="true">
            |$domains
            |    </domain-config>
            |</network-security-config>
            |""".trimMargin(),
        )
    }
}

val networkSecurityConfig = tasks.register<EduNetworkSecurityConfig>("eduNetworkSecurityConfig") {
    cleartextHosts.set(listOfNotNull("127.0.0.1", apiUri?.takeIf { it.scheme == "http" }?.host).distinct())
    outputDir.set(layout.buildDirectory.dir("generated/edu/network-security/res"))
}

androidComponents {
    onVariants { variant ->
        if (variant.buildType != "debug") {
            variant.sources.res?.addGeneratedSourceDirectory(networkSecurityConfig, EduNetworkSecurityConfig::outputDir)
        }
    }
}

// ─── Development: phone ↔ backend on this computer over USB ──────────────────
// Before every debug build (`flutter run`), forwards the phone's localhost:<port> to this
// computer with `adb reverse` when API_BASE_URL in ../../.env points at localhost. The app then
// reaches the backend started with `npm run dev`. Never fails the build.
val apiPort: Int? = apiUri
    ?.takeIf { it.host in setOf("localhost", "127.0.0.1") }
    ?.let { uri -> if (uri.port > 0) uri.port else if (uri.scheme == "https") 443 else 80 }

val adbExecutable: File? = run {
    val localProperties = Properties().apply {
        val file = rootProject.file("local.properties")
        if (file.exists()) file.inputStream().use { load(it) }
    }
    val sdk = localProperties.getProperty("sdk.dir") ?: System.getenv("ANDROID_HOME") ?: System.getenv("ANDROID_SDK_ROOT")
    val name = if (System.getProperty("os.name").lowercase().contains("windows")) "adb.exe" else "adb"
    sdk?.let { File(it, "platform-tools/$name") }?.takeIf { it.exists() }
}

val forwardApiPort = tasks.register("eduForwardApiPort") {
    description = "adb reverse tcp:<API port> for connected devices, so they reach the local backend"
    outputs.upToDateWhen { false }
    onlyIf { apiPort != null && adbExecutable != null }
    doLast {
        fun adb(vararg args: String): String? = runCatching {
            val process = ProcessBuilder(listOf(adbExecutable!!.absolutePath) + args).redirectErrorStream(true).start()
            val output = process.inputStream.bufferedReader().readText()
            if (process.waitFor() == 0) output else null
        }.getOrNull()

        val lines = adb("devices").orEmpty().lines().map { it.trim() }
        if (lines.any { it.endsWith("\tunauthorized") }) {
            logger.lifecycle("A phone is connected but not authorized: accept the USB debugging prompt on the phone.")
        }
        for (serial in lines.filter { it.endsWith("\tdevice") }.map { it.substringBefore('\t') }) {
            val forwarded = adb("-s", serial, "reverse", "tcp:$apiPort", "tcp:$apiPort") != null
            logger.lifecycle(
                if (forwarded) "adb reverse tcp:$apiPort on $serial: the app reaches the backend on this computer"
                else "adb reverse failed on $serial",
            )
        }
    }
}

tasks.matching { it.name == "preDebugBuild" }.configureEach { dependsOn(forwardApiPort) }
