import UIKit
import Flutter
import KakaoSDKCommon

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      KakaoSDK.initSDK(appKey: "e6e9b57f504d038570209f2d74e89b38")
      //e6e9b57f504d038570209f2d74e89b38
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
