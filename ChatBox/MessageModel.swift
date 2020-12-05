//
//  MessageModel.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

import UIKit
import AVFoundation

struct Message: Codable {
    enum MsgType: String, Codable {
        case textMsg
        case picMsg
        case audioMsg
        case videoMsg
        case newPeopleCome
        case systemTip
    }
    var type: MsgType
    var speaker: String
    var text: String?
    var imageData: Data?
    var audioData: Data?
    var videoUrl: URL?
    
    func getAttributedText() -> NSMutableAttributedString {
        
        let font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        let nsmat = NSMutableAttributedString()
        
        switch type {
        case .textMsg:
            let name = NSAttributedString(string: speaker + ": ", attributes: [.font: font, .foregroundColor: UIColor.blue])
            let text = NSAttributedString(string: self.text ?? "", attributes: [.font: font, .foregroundColor: UIColor.black])
            nsmat.append(name)
            nsmat.append(text)
        case .picMsg:
            let name = NSAttributedString(string: speaker + ": ", attributes: [.font: font, .foregroundColor: UIColor.blue])
            nsmat.append(name)
        case .audioMsg:
            let name = NSAttributedString(string: speaker + ": ", attributes: [.font: font, .foregroundColor: UIColor.blue])
            nsmat.append(name)
        case .videoMsg:
            let name = NSAttributedString(string: speaker + ": ", attributes: [.font: font, .foregroundColor: UIColor.blue])
            nsmat.append(name)
        case .newPeopleCome:
            let name = NSAttributedString(string: speaker, attributes: [.font: font, .foregroundColor: UIColor.blue])
            let come = NSAttributedString(string: " 来了", attributes: [.font: font, .foregroundColor: UIColor.gray])
            nsmat.append(name)
            nsmat.append(come)
        case .systemTip:
            let tip = NSAttributedString(string: SYSTEM_TIP_TEXT, attributes: [.font: font, .foregroundColor: UIColor.blue])
            nsmat.append(tip)
        }
        
        return nsmat
    }
    
    func getContentHeight(contentWidth: CGFloat) -> CGFloat {
        
        let width = contentWidth - PADDING_OF_TEXT_H * 2
        let textSize = CGSize(width: width, height: 10000.0)
        let t = self.getAttributedText()
        // 文字区域的大小
        let textRect = t.boundingRect(with: textSize, options: .usesLineFragmentOrigin, context: nil)
        
        if let _ = self.audioData {
            // 返回语音消息的高度
            return ceil(textRect.height) + AUDIO_ICON_H + PADDING_OF_TEXT_V * 3
        }
        
        if let _ = self.videoUrl {
            // 返回视频消息的高度
            return ceil(textRect.height) + VIDEO_AREA_H + PADDING_OF_TEXT_V * 3
        }
        
        guard let data = self.imageData, let image = UIImage(data: data) else {
            // 返回只有文字的高度
            return ceil(textRect.height) + PADDING_OF_TEXT_V * 2
        }
        
        // 图片高度
        let imageHeight = width * image.size.height / image.size.width
        // 返回图片消息的高度
        return ceil(textRect.height + imageHeight) + PADDING_OF_TEXT_V * 3
    }
    
}
