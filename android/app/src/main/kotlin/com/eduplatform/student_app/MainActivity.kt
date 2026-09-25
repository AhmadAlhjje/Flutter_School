package com.eduplatform.student_app

import android.annotation.SuppressLint
import android.os.Bundle
import android.provider.Settings
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Screen protection (spec §38): screenshots and screen recordings of the app show a
        // black surface, and the app content is hidden in the recent-apps preview.
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "androidId" -> result.success(androidId())
                else -> result.notImplemented()
            }
        }
    }

    /** Stable per (signing key, user, device) identifier used for device binding. */
    @SuppressLint("HardwareIds")
    private fun androidId(): String? = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)

    private companion object {
        const val DEVICE_CHANNEL = "edu.platform/device"
    }
}
