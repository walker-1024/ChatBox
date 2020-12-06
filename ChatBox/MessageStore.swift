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
        saveAsJsonFile()
    }
    
    // 保存为Json文件
    func saveAsJsonFile() {
        
        let dic = ["messages": messages]
        let path = "/Users/macbookpro/Desktop/data.json"
        do {
            let enc = JSONEncoder()
            enc.outputFormatting = .prettyPrinted
            let data = try enc.encode(dic)
            // 若文件存在则删掉新建
            let fm = FileManager()
            if fm.fileExists(atPath: path) {
                try fm.removeItem(atPath: path)
                fm.createFile(atPath: path, contents: nil, attributes: nil)
            } else {
                fm.createFile(atPath: path, contents: nil, attributes: nil)
            }
            if let fh = FileHandle(forWritingAtPath: path) {
                fh.write(data)
                try fh.close()
            }
        } catch {
            print("!!!!!!!!")
        }
    }
    
}
