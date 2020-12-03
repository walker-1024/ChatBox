//
//  MessageClient.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit
import AVFoundation

class MessageClient: NSObject {
    
    var receivedMsg: ((_ message: Message) -> Void)?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMessage(notification:)), name: Notification.Name("sendMessage"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func receiveMessage(notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let speaker = userInfo["speaker"] as! String
        let text = userInfo["text"] as? String
        let imageData = userInfo["imageData"] as? Data
        let audioData = userInfo["audioData"] as? Data
        
        print(userInfo)
        
        let m = Message(type: .textMsg, speaker: speaker, text: text, imageData: imageData, audioData: audioData)
        receivedMsg!(m)
        
        if speaker == "我" {
            if text == "menhear" {
                ChatBot.menhear()
            } else if text == "语音" {
                ChatBot.voice()
            } else {
                ChatBot.chat(text: text!)
            }
        }
        
    }
}
