package com.eduplatform.student_app

import android.annotation.SuppressLint
import android.media.AudioAttributes
import android.media.AudioManager
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.function.Consumer

/**
 * Screen protection (see lib/core/security/screen_protection.dart):
 * - Picture: FLAG_SECURE — screenshots and screen recordings of the app are black, and the app is
 *   hidden in the recent-apps preview.
 * - Sound: no app (not even a system screen recorder) may capture the app's audio (Android 10+),
 *   so a screen recording of the app contains neither picture nor sound.
 * - Android 15+: the app is told when it is being recorded; the player then stops the video.
 */
class MainActivity : FlutterActivity() {
    private var captureSink: EventChannel.EventSink? = null
    private var beingRecorded = false

    private val recordingCallback: Consumer<Int>? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM) {
            Consumer { state -> onRecordingState(state) }
        } else {
            null
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            getSystemService(AudioManager::class.java)?.setAllowedCapturePolicy(AudioAttributes.ALLOW_CAPTURE_BY_NONE)
        }
        super.onCreate(savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM) {
            onRecordingState(windowManager.addScreenRecordingCallback(mainExecutor, recordingCallback!!))
        }
    }

    override fun onStop() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM) {
            windowManager.removeScreenRecordingCallback(recordingCallback!!)
        }
        super.onStop()
    }

    private fun onRecordingState(state: Int) {
        beingRecorded = Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM &&
            state == WindowManager.SCREEN_RECORDING_STATE_VISIBLE
        captureSink?.success(beingRecorded)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, DEVICE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "androidId" -> result.success(androidId())
                else -> result.notImplemented()
            }
        }
        MethodChannel(messenger, SCREEN_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isCaptured" -> result.success(beingRecorded)
                else -> result.notImplemented()
            }
        }
        EventChannel(messenger, CAPTURE_EVENTS).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                captureSink = events
                events.success(beingRecorded)
            }

            override fun onCancel(arguments: Any?) {
                captureSink = null
            }
        })
    }

    /** Stable per (signing key, user, device) identifier used for device binding. */
    @SuppressLint("HardwareIds")
    private fun androidId(): String? = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)

    private companion object {
        const val DEVICE_CHANNEL = "edu.platform/device"
        const val SCREEN_CHANNEL = "edu.platform/screen"
        const val CAPTURE_EVENTS = "edu.platform/screen/capture"
    }
}
