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
        let image = userInfo["image"] as? UIImage
        let audio = userInfo["audio"] as? AVAudioPlayer
        
        print(speaker, text as Any)
        
        let m = Message(type: .textMsg, speaker: speaker, text: text, image: image, audio: audio)
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
