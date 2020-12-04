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
            make.size.equalTo(CGSize(width: screenWidth * 0.9, height: screenWidth * 1.5))
            make.center.equalToSuperview()
        }
        cbv.messageView.delegate = screenMessageStore
        cbv.messageView.dataSource = screenMessageStore
        
        client.receivedMsg = { message in
            self.store.addNewMsg(message)
        }
        
        store.addedMsg = { message in
            self.screenMessageStore.addNewMessage(msg: message)
            self.cbv.addedNewMessage(message: message)
        }
        
        // 1.0秒后发送系统提示消息
        perform(#selector(sendSystemMsg), with: nil, afterDelay: 1.0)
        
    }
    
    @objc func sendSystemMsg() {
        let m = Message(type: .systemTip, speaker: nil, text: nil)
        screenMessageStore.addNewMessage(msg: m)
        cbv.addedNewMessage(message: m)
        
        let t = Message(type: .videoMsg, speaker: nil, text: nil, videoUrl: URL(string: "http://qkt3l2hz4.hn-bkt.clouddn.com/ces.mp4")!)
        screenMessageStore.addNewMessage(msg: t)
        cbv.addedNewMessage(message: t)
    }


}

