//
//  ChatBoxView.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit
import SnapKit

class ChatBoxView: UIView {
    
    var newMsgNum: Int = 0 // 未读消息计数
    
    let messageView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: PADDING_BETWEEN_CELLS, left: 0.0, bottom: PADDING_BETWEEN_CELLS, right: 0.0)
        // minimumLineSpacing指同一个section内部item的"滚动方向的间距"
        // minimumInteritemSpacing指同一个section内部item的"和滚动方向垂直的方向的间距"
        // 这里只需要设置竖直方向的间距
        layout.minimumLineSpacing = PADDING_BETWEEN_CELLS
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return v
    }()
    let specialMessageView = UIView()
    let newMsgTipView = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(specialMessageView)
        specialMessageView.backgroundColor = UIColor.black
        specialMessageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.lessThanOrEqualTo(50)
        }

        self.addSubview(messageView)
        messageView.backgroundColor = UIColor.white
        messageView.snp.makeConstraints { make in
            make.bottom.equalTo(specialMessageView.snp.top)
            make.leading.trailing.top.equalToSuperview()
        }
        // 将整个CollectionView翻转
        messageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        messageView.showsVerticalScrollIndicator = false
        messageView.register(MessageCell.self, forCellWithReuseIdentifier: "MessageCell")
        
        self.addSubview(newMsgTipView)
        newMsgTipView.snp.makeConstraints { make in
            make.trailing.equalTo(messageView.snp.trailing).offset(-15)
            make.bottom.equalTo(messageView.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
        newMsgTipView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        newMsgTipView.layer.cornerRadius = 15
        newMsgTipView.layer.masksToBounds = true
        newMsgTipView.textAlignment = .center
        newMsgTipView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        newMsgTipView.font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        newMsgTipView.isHidden = true
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(newMsgTipViewClicked))
        gr.numberOfTapsRequired = 1
        self.addGestureRecognizer(gr)
    }
    
    func addedNewMessage(text: String) {
        let prevOffset = messageView.contentOffset
        messageView.reloadData()
        // 当不在最下面时，保持视图岿然不动
        if prevOffset.y > PADDING_BETWEEN_CELLS + 5.0 {
            let textSize = CGSize(width: messageView.bounds.width - PADDING_OF_CELL_H * 2 - PADDING_OF_TEXT_H * 2, height: 10000.0)
            let font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
            let rect = text.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            
            let deltaOffset = ceil(rect.height) + PADDING_OF_TEXT_V * 2 + PADDING_BETWEEN_CELLS
            messageView.contentOffset = CGPoint(x: prevOffset.x, y: prevOffset.y + deltaOffset)
            
            addNewMsgNum()
        } else {
            messageView.contentOffset = CGPoint.zero
        }
    }
    
    func addNewMsgNum() {
        newMsgNum += 1
        newMsgTipView.isHidden = false
        newMsgTipView.text = "\(newMsgNum)"
    }
    
    func subNewMsgNum() {
        
    }
    
    @objc func newMsgTipViewClicked() {
        messageView.contentOffset = CGPoint.zero
        newMsgNum = 0
        newMsgTipView.isHidden = true
    }
    
}
