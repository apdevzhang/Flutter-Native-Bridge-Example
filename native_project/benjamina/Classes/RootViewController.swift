//
//  RootViewController.swift
//  benjamina
//
//  Created by BANYAN on 2019/12/26.
//  Copyright © 2019 BANYAN. All rights reserved.
//

import UIKit
import RxAlertController

class RootViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        // 开启一个定时器测试向flutter发送信息
        let timer = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        
        let dictionary = ["word": "hello"]
        
        timer.subscribe(onNext: { (time) in
            if let jsonString = dictionary.jsonString() {
                SwiftFlutterBridge.shared.sendMessageToFlutter(message: jsonString)
            }
        }).disposed(by: rx.disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI
    func initUI() {
        self.view.backgroundColor = .white
        
        // 注册flutter代理
        registerFlutter()
    }
    
    // MARK: - Event
    
    
    // MARK: - Notification
    
    
    // MARK: - Public Methods
    
    
    // MARK: - Private Methods
    
    // 注册与flutter通信的代理
    private func registerFlutter() {
        SwiftFlutterBridge.shared.delegate = self

        DispatchQueue.main.async {
            self.addChild(SwiftFlutterBridge.shared.flutterViewController)
            self.view.addSubview(SwiftFlutterBridge.shared.flutterViewController.view)
            SwiftFlutterBridge.shared.flutterViewController.view.frame = self.view.bounds
            SwiftFlutterBridge.shared.flutterViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    // 展示收到flutter传来的信息
    private func handleReceivedMessage(medhod: String, arguments: Any) {
        self.view.makeToast("收到flutter传来的的方法为:\(medhod)")
        
        // flutter传过来的方法
        print("flutter传过来的方法method:\(String(describing: method)), 参数arguments:\(arguments)")
    }
    
    // MARK: - Delegate
    
    
    // MARK: - Setter
    
    
    // MARK: - Getter
    
}


// MARK: - SwiftFlutterBridgeDelegate
extension RootViewController: SwiftFlutterBridgeDelegate {
    func methodChannelCall(method: String, arguments: Any, result: (Any?) -> Void) {
        
        self.handleReceivedMessage(medhod: method, arguments: arguments)
        
        switch method {
        /// 打开相册
        case FlutterBridgeConst.OPEN_GALLERY:

            break
            
        /// 拍照
        case FlutterBridgeConst.TAKE_PHOTO:

            break
            
        /// 导航
        case FlutterBridgeConst.TO_NAVIGATION:

            break
            
        case FlutterBridgeConst.REMOVE_DATA:
            
            break
            
        default:
            break
        }
    }
}
