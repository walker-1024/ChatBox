//
//  MessageModel.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

struct Message: Codable {
    enum MsgType: String, Codable {
        case textMsg
        case picMsg
        case audioMsg
        case newPeopleCome
        case systemTip
    }
    var type: MsgType
    var speaker: String?
    var text: String?
    
    func getString() -> String {
        switch type {
        case .textMsg:
            return (speaker ?? "") + ": " + (text ?? "")
        case .picMsg:
            return ""
        case .audioMsg:
            return ""
        case .newPeopleCome:
            return speaker! + " 来了"
        case .systemTip:
            return SYSTEM_TIP_TEXT
        }
    }
}
