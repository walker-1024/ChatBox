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
        let videoUrl = userInfo["videoUrl"] as? URL
        
        print(userInfo)
        
        let m = Message(type: .textMsg, speaker: speaker, text: text, imageData: imageData, audioData: audioData, videoUrl: videoUrl)
        receivedMsg!(m)
        
        if speaker == "我" {
            if text == "menhera" {
                ChatBot.menhear()
            } else if text == "语音" {
                ChatBot.voice()
            } else if text == "视频" {
                ChatBot.video()
            } else {
                ChatBot.chat(text: text!)
            }
        }
        
    }
}
