//
//  MessageClient.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit

class MessageClient: NSObject {
    
    var receivedMsg: ((_ message: Message) -> Void)?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveTextMessage(notification:)), name: Notification.Name("sendMessage"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func receiveTextMessage(notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let speaker = userInfo["speaker"] as! String
        let text = userInfo["text"] as? String
        let image = userInfo["image"] as? UIImage
        
        print(speaker, text as Any)
        
        let m = Message(type: .textMsg, speaker: speaker, text: text, image: image)
        receivedMsg!(m)
        
        if speaker == "我" {
            if text == "menhear" {
                ChatBot.menhear()
            } else {
                ChatBot.chat(text: text!)
            }
        }
        
    }
}
