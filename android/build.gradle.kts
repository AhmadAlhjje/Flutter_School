allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
// One NDK for the app and every plugin module: `edu.ndkVersion` in gradle.properties
// (can be overridden with --android-project-arg=edu.ndkVersion=<version>).
val forcedNdkVersion: String? = providers.gradleProperty("edu.ndkVersion").orNull
if (forcedNdkVersion != null) {
    subprojects {
        afterEvaluate {
            extensions.findByName("android")?.let { android ->
                android.javaClass.getMethod("setNdkVersion", String::class.java).invoke(android, forcedNdkVersion)
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
