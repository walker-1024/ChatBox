//
//  MessageStore.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit

class MessageStore: NSObject {
    
    var messages: [Message] = originMsgs
    
    var displayRange = (start: 0, end: 100)
    
    var addedMsg: ((_ message: Message) -> Void)?
    
    func addNewMsg(_ newMessage: Message) {
        messages.append(newMessage)
        addedMsg!(newMessage)
    }
    
    func prevMsg() -> [Message]? {
        if messages.count <= displayRange.end { return nil }
        var t: [Message] = []
        if messages.count > displayRange.end + 50 {
            for i in (displayRange.end+1)..<(displayRange.end+51) {
                t.append(messages[i])
            }
        } else {
            for i in (displayRange.end+1)..<messages.count {
                t.append(messages[i])
            }
        }
        displayRange.start += t.count
        displayRange.end += t.count
        return t
    }
    
    func nextMsg() -> [Message]? {
        if displayRange.start == 0 { return nil }
        var t: [Message] = []
        if displayRange.start > 50 {
            for i in (displayRange.start-51)..<(displayRange.start-1) {
                t.append(messages[i])
            }
        } else {
            for i in 0..<(displayRange.start-1) {
                t.append(messages[i])
            }
        }
        displayRange.start -= t.count
        displayRange.end -= t.count
        return t
    }
    
}
