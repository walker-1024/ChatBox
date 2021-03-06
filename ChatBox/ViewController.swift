//
//  ViewController.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    
    let client = MessageClient()
    let store = MessageStore()
    let chatBoxView = ChatBoxView()
    let screenMessageStore = ScreenMessageStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(chatBoxView)
        chatBoxView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: screenWidth * 0.9, height: screenWidth * 1.5))
            make.center.equalToSuperview()
        }
        chatBoxView.messageView.delegate = screenMessageStore
        chatBoxView.messageView.dataSource = screenMessageStore
        
        client.receivedMsg = { message in
            self.store.addNewMsg(message)
        }
        
        store.addedMsg = { message in
            self.screenMessageStore.addNewMessage(msg: message)
            self.chatBoxView.addedNewMessage(message: message)
        }
        
        // 1.0秒后发送系统提示消息
        perform(#selector(sendSystemMsg), with: nil, afterDelay: 1.0)
        
    }
    
    @objc func sendSystemMsg() {
        let m = Message(type: .systemTip, speaker: "")
        screenMessageStore.addNewMessage(msg: m)
        chatBoxView.addedNewMessage(message: m)
    }

}

