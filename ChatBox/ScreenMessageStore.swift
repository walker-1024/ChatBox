//
//  ScreenMessageStore.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit

class ScreenMessageStore: NSObject {
    
    var messages: [Message] = originMsgs
    
    var requestPrevMsg: (() -> Void)?
    var requestNextMsg: (() -> Void)?
    
    func addNewMessage(msg: Message) {
        messages.insert(msg, at: 0)
        if messages.count > 100 {
            messages.removeLast()
        }
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
        cell.setupCell(message: messages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 返回每个cell的大小
        
        let width = collectionView.bounds.width - PADDING_OF_CELL_H * 2
        let height = messages[indexPath.row].getContentHeight(contentWidth: width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > 90 {
            requestPrevMsg!()
        } else if indexPath.row < 1 {
            requestNextMsg!()
        }
    }
}
