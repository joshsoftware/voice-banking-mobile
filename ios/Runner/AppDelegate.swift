import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

    private let pipecatBridge = PipecatBridge()
    private let pipecatTag = "Pipecat/AppDelegate"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        if let controller = window?.rootViewController as? FlutterViewController {
            let messenger = controller.binaryMessenger
            NSLog("\(pipecatTag): registering Pigeon host + event stream")
            PipecatHostApiSetup.setUp(binaryMessenger: messenger, api: pipecatBridge)
            StreamEventsStreamHandler.register(
                with: messenger, streamHandler: pipecatBridge
            )
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
