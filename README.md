## Flutter Native Bridge Example

   > 这里描述的是flutter与原生工程的通信交互


### [iOS](native_project)
    
   > 我的做法是写了个文件覆盖了methodChannel的代理方法，将收发功能封装进了一个类`SwiftFlutterBridge.swift`、并将通信约定字符写在了宏定义文件里`FlutterBridgeConst.swift`
   
 - 必不可少的约定字符为以下三种(根据自己的项目需要去设定)
 ```Swift
    static let MethodChannel = "com.example.flutter/method"
    
    static let EventChannel = "com.example.flutter/event"
    
    static let BasicMessageChannel = "com.example.flutter/basicMessage"
 ```
   

 - 在AppDelegate里注册通信
 ```Swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 注册与Flutter的通信
        SwiftFlutterBridge.shared.load(methodChannel: FlutterBridgeConst.MethodChannel, eventChannel: FlutterBridgeConst.EventChannel, messageChannel: FlutterBridgeConst.BasicMessageChannel)
        
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }
 ```
 
 - 遵守协议代理及加载flutter页面
   可以根据需要仅仅跳转或是直接加载
   
 ```Swift
       SwiftFlutterBridge.shared.delegate = self

        DispatchQueue.main.async {
            self.addChild(SwiftFlutterBridge.shared.flutterViewController)
            self.view.addSubview(SwiftFlutterBridge.shared.flutterViewController.view)
            SwiftFlutterBridge.shared.flutterViewController.view.frame = self.view.bounds
            SwiftFlutterBridge.shared.flutterViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
 ```
 
 - 原生向flutter发送信息
 ```Swift
     func sendMessageToFlutter(message: Any) {
        if let messageChannel = basicMessageChannel {
            messageChannel.sendMessage(message)
        }
    }
 ```

### [Flutter](flutter_project)

> Flutter这边的方法是使用工厂模式将`EventChannel`、`BasicMessageChannel`、`MethodChannel`写在了`flutter_bridge_manager.dart`文件里

- 向原生发送信息
```Dart

    // 这个字典紧紧是为了举个例子
    Map<String, dynamic> map = {"name": listTitleArray[index], "arguments": "test"};

    MethodChannelManager.instance.methodChannel
        .invokeMethod(listTitleArray[index], map);
```

- 接收native发来的信息
```Dart
    BasicMessageChannelManager.instance.basicMessageChannel.setMessageHandler((message) async {
      Map map = json.decode(message);
      print('basicMessageMethod:' + '$map');
    });
```



### 参考链接
- [Upgrading Flutter added to existing iOS Xcode project](https://github.com/flutter/flutter/wiki/Upgrading-Flutter-added-to-existing-iOS-Xcode-project)
- [Add Flutter to existing app](https://flutter.dev/docs/development/add-to-app)
- [MethodChannel、EventChannel](https://blog.csdn.net/mcy456/article/details/96774539)
