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
        
        screenMessageStore.requestPrevMsg = {
            if let ms = self.store.prevMsg() {
                self.screenMessageStore.messages.removeFirst(ms.count)
                self.screenMessageStore.messages += ms
                self.chatBoxView.messageView.reloadData()
            }
        }
        
        screenMessageStore.requestNextMsg = {
            if let ms = self.store.nextMsg() {
                self.screenMessageStore.messages.removeLast(ms.count)
                self.screenMessageStore.messages.insert(contentsOf: ms, at: 0)
                self.chatBoxView.messageView.reloadData()
            }
        }
        
        // 1.0秒后发送系统提示消息
        perform(#selector(sendSystemMsg), with: nil, afterDelay: 1.0)
        
        ceshi()
    }
    
    @objc func sendSystemMsg() {
        let m = Message(type: .systemTip, speaker: "")
        screenMessageStore.addNewMessage(msg: m)
        chatBoxView.addedNewMessage(message: m)
    }
    
    func ceshi() {
        let b = UIButton()
        view.addSubview(b)
        b.backgroundColor = UIColor.black
        b.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        b.addTarget(self, action: #selector(c), for: .touchUpInside)
    }
    
    static var num = 0
    @objc func c() {
        NotificationCenter.default.post(name: Notification.Name("sendMessage"), object: self, userInfo: ["speaker": "测试", "text": " \(ViewController.num) "])
        ViewController.num += 1
    }

}

