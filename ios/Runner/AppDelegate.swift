import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "ScreenProtection") {
      ScreenProtection.register(messenger: registrar.messenger())
    }
  }
}

/// iOS side of lib/core/security/screen_protection.dart.
///
/// iOS does not let apps block screenshots. What it allows, and what this does:
/// - report whether the screen is being recorded / mirrored (`isCaptured` + live changes), so
///   the app hides the video while that is happening;
/// - report screenshots after they are taken, so the app can warn the student.
enum ScreenProtection {
  static func register(messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "edu.platform/screen", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        switch call.method {
        case "isCaptured":
          result(isCaptured)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    FlutterEventChannel(name: "edu.platform/screen/capture", binaryMessenger: messenger)
      .setStreamHandler(NotificationStreamHandler(name: UIScreen.capturedDidChangeNotification) { isCaptured })
    FlutterEventChannel(name: "edu.platform/screen/screenshot", binaryMessenger: messenger)
      .setStreamHandler(NotificationStreamHandler(name: UIApplication.userDidTakeScreenshotNotification) { true })
  }

  static var isCaptured: Bool {
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    return scenes.contains { scene in
      if #available(iOS 17.0, *) {
        return scene.traitCollection.sceneCaptureState == .active
      }
      return scene.screen.isCaptured
    }
  }
}

/// Forwards a system notification to Dart while someone listens on the event channel.
final class NotificationStreamHandler: NSObject, FlutterStreamHandler {
  private let name: Notification.Name
  private let value: () -> Any
  private var observer: NSObjectProtocol?

  init(name: Notification.Name, value: @escaping () -> Any) {
    self.name = name
    self.value = value
  }

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
      guard let self else { return }
      events(self.value())
    }
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    if let observer {
      NotificationCenter.default.removeObserver(observer)
    }
    observer = nil
    return nil
  }
}
