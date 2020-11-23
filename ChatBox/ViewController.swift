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
    let cbv = ChatBoxView()
    let screenMessageStore = ScreenMessageStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(cbv)
        cbv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: screenWidth * 0.9, height: screenWidth * 1.2))
            make.center.equalToSuperview()
        }
        cbv.messageView.delegate = screenMessageStore
        cbv.messageView.dataSource = screenMessageStore
        
        client.receivedMsg = { message in
            self.store.addNewMsg(message)
        }
        
        store.addedMsg = { message in
            self.screenMessageStore.addNewMessage(msg: message)
            self.cbv.addedNewMessage(text: message.getString())
        }
        
        ceshi()
        
        // 1.0秒后发送系统提示消息
        perform(#selector(sendSystemMsg), with: nil, afterDelay: 1.0)
        
    }
    
    @objc func sendSystemMsg() {
        let m = Message(type: .systemTip, speaker: nil, text: nil)
        screenMessageStore.addNewMessage(msg: m)
        cbv.addedNewMessage(text: m.getString())
    }
    
    func ceshi() {
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.size.equalTo(80)
        }
        btn.backgroundColor = UIColor.white
        btn.setTitle("增加", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(ccc), for: .touchDown)
    }
    
    @objc func ccc() {
        NotificationCenter.default.post(name: Notification.Name("sendMessage"), object: self, userInfo: ["speaker": "？？？", "text": "新加消息"])
    }


}

