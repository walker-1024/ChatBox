//
//  MessageModel.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit
import AVFoundation
// struct Message: Codable {
struct Message {
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
    var image: UIImage?
    var audio: AVAudioPlayer?
    
    func getString() -> String {
        switch type {
        case .textMsg:
            return (speaker ?? "") + ": " + (text ?? "")
        case .picMsg:
            return (speaker ?? "") + ": "
        case .audioMsg:
            return (speaker ?? "") + ": "
        case .newPeopleCome:
            return speaker! + " 来了"
        case .systemTip:
            return SYSTEM_TIP_TEXT
        }
    }
    
    func getContentHeight(contentWidth: CGFloat) -> CGFloat {
        
        let width = contentWidth - PADDING_OF_TEXT_H * 2
        let str = self.getString()
        let textSize = CGSize(width: width, height: 10000.0)
        let font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        // 文字区域的大小
        let textRect = str.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        guard let _ = self.audio else { return ceil(textRect.height) + PADDING_OF_TEXT_V * 2 }
        
        guard let image = self.image else { return ceil(textRect.height) + PADDING_OF_TEXT_V * 2 }
        // 图片高度
        let imageHeight = image.size.height / image.size.width * width
        
        return ceil(textRect.height + imageHeight) + PADDING_OF_TEXT_V * 3
    }
    
}
