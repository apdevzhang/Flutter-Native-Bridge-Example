import UIKit
import Flutter
import FlutterPluginRegistrant

protocol SwiftFlutterBridgeDelegate: NSObjectProtocol {
    func methodChannelCall(method: String, arguments: Any, result: FlutterResult)
}

class SwiftFlutterBridge: NSObject {
    
    // MARK: - Public Method
    
    /// 注册通信协议
    func load(methodChannel: String, eventChannel: String, messageChannel: String) {
        self.flutterEngine?.run(withEntrypoint: nil)
        
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        
        self.flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: nil)
        
        let eventChannel = FlutterEventChannel(name: eventChannel, binaryMessenger: flutterViewController.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        let methodChannel = FlutterMethodChannel(name: methodChannel, binaryMessenger: flutterViewController.binaryMessenger)
        
        basicMessageChannel = FlutterBasicMessageChannel(name: messageChannel, binaryMessenger: flutterViewController.binaryMessenger, codec: FlutterStringCodec.sharedInstance())
        
        methodChannel.setMethodCallHandler { (methodCall, result) in
            if self.delegate != nil {
                self.delegate?.methodChannelCall(method: methodCall.method, arguments: methodCall.arguments as Any, result: result)
            }
        }
    }
    
    // 给Flutter发送信息
    func sendMessageToFlutter(message: Any) {
        if let messageChannel = basicMessageChannel {
            messageChannel.sendMessage(message)
        }
    }
    
    // MARK: - Properties
    static let shared = SwiftFlutterBridge()
    
    var delegate: SwiftFlutterBridgeDelegate?
    
    private var flutterEventSink: FlutterEventSink?
    
    var flutterViewController = FlutterViewController()
    
    private var basicMessageChannel: FlutterBasicMessageChannel?
    
    private let flutterEngine = FlutterEngine.init(name: "io.flutter", project: nil)
}

// MARK: - FlutterStreamHandler
extension SwiftFlutterBridge: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        self.flutterEventSink = events
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
