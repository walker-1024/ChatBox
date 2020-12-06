//
//  MessageStore.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit

class MessageStore: NSObject {
    
    var messages: [Message] = originMsgs
    
    var addedMsg: ((_ message: Message) -> Void)?
    
    func addNewMsg(_ newMessage: Message) {
        messages.append(newMessage)
        addedMsg!(newMessage)
    }
    
}
