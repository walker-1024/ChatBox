//
//  Config.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/22.
//

import UIKit

let testMsgs = [Message(type: .textMsg, speaker: "小明", text: "初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息初始消息初始消息"),
                Message(type: .textMsg, speaker: "小明", text: "初始消息"),
]

// 字体大小
public let TEXT_FONT_SIZE: CGFloat = 25.0
// Cell和整个聊天框之间的间距（左右）
public let PADDING_OF_CELL_H: CGFloat = 15.0
// 消息（Cell）之间的间距
public let PADDING_BETWEEN_CELLS: CGFloat = 10.0
// 文字和Cell边框之间的间距（左右）
public let PADDING_OF_TEXT_H: CGFloat = 10.0
// 文字和Cell边框之间的间距（上下）
public let PADDING_OF_TEXT_V: CGFloat = 8.0
// 语音图标高度
public let AUDIO_ICON_H: CGFloat = 40
// 视频高度
public let VIDEO_AREA_H: CGFloat = 150
// 系统提示内容
public let SYSTEM_TIP_TEXT: String = "现有功能：\n发送menhera获得随机menhera图片；\n发送文字和机器人聊天；\n发送\"语音\"获得绕口令；发送\"视频\"获得视频。"
