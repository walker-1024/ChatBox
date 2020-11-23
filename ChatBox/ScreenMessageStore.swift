//
//  ScreenMessageStore.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit

class ScreenMessageStore: NSObject {
    
    var messages: [Message] = testMsgs
    
    func addNewMessage(msg: Message) {
        messages.insert(msg, at: 0)
    }
    
}

extension ScreenMessageStore: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.setupCell(text: messages[indexPath.row].getString())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let str = messages[indexPath.row].getString()
        let textSize = CGSize(width: collectionView.bounds.width - PADDING_OF_CELL_H * 2 - PADDING_OF_TEXT_H * 2, height: 10000.0)
        let font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        let rect = str.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return CGSize(width: collectionView.bounds.width - PADDING_OF_CELL_H * 2, height: ceil(rect.height) + PADDING_OF_TEXT_V * 2)
    }
}
