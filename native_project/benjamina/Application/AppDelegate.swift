//
//  AppDelegate.swift
//  benjamina
//
//  Created by BANYAN on 2019/12/26.
//  Copyright © 2019 BANYAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 注册与Flutter的通信
        SwiftFlutterBridge.shared.load(methodChannel: FlutterBridgeConst.MethodChannel, eventChannel: FlutterBridgeConst.EventChannel, messageChannel: FlutterBridgeConst.BasicMessageChannel)
        
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

