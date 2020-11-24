//
//  ChatBot.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/23.
//

// 模拟一个聊天机器人

import UIKit

class ChatBot: NSObject {
    
    static let session = URLSession(configuration: .default)
    
    static func chat(text: String) {
        let urlStr = "http://api.qingyunke.com/api.php?key=free&appid=0&msg=\(text)"
        let url = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let request: URLRequest = URLRequest(url: url)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String: Any]
                    let content = dict?["content"] as! String
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("sendMessage"), object: self, userInfo: ["speaker": "机器人", "text": content])
                    }
                } catch {
                }
            }
        }
        dataTask.resume()
    }
    
    static func menhear() {
        let urlStr = "https://api.ixiaowai.cn/mcapi/mcapi.php"
        let request = URLRequest(url: URL(string: urlStr)!)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    
                } catch {
                }
            }
        }
        dataTask.resume()
    }
    
}
