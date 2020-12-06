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
    let textField = UITextField()
    let sendBtn = UIButton()
    let newMsgTipView = UILabel()
    
    var tgr: UITapGestureRecognizer!
    
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
        
        self.addSubview(sendBtn)
        sendBtn.backgroundColor = UIColor.clear
        sendBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-PADDING_OF_CELL_H)
            make.bottom.equalTo(-PADDING_BETWEEN_CELLS)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        sendBtn.layer.cornerRadius = 10
        sendBtn.layer.masksToBounds = true
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        sendBtn.addTarget(self, action: #selector(sendBtnClicked), for: .touchUpInside)
        
        self.addSubview(textField)
        textField.backgroundColor = #colorLiteral(red: 0.8816456199, green: 0.8764049411, blue: 0.8856742382, alpha: 1)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(PADDING_OF_CELL_H)
            make.trailing.equalTo(sendBtn.snp.leading).offset(-5)
            make.bottom.equalTo(-PADDING_BETWEEN_CELLS)
            make.height.equalTo(40)
        }
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        textField.textAlignment = .left
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.isEnabled = true
        textField.keyboardType = .default
        textField.returnKeyType = .send
        textField.delegate = self

        self.addSubview(messageView)
        messageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        messageView.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.top).offset(-PADDING_BETWEEN_CELLS)
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
        
        tgr = UITapGestureRecognizer(target: self, action: #selector(newMsgTipViewClicked))
        tgr.numberOfTapsRequired = 1
        tgr.isEnabled = false
        self.addGestureRecognizer(tgr)
    }
    
    func addedNewMessage(message: Message) {
        let prevOffset = messageView.contentOffset
        messageView.reloadData()
        // 当不在最下面时，保持视图岿然不动
        if prevOffset.y > PADDING_BETWEEN_CELLS + 5.0 {
            
            let cellHeight = message.getContentHeight(contentWidth: messageView.bounds.width - PADDING_OF_CELL_H * 2)
            let deltaOffset = ceil(cellHeight) + PADDING_BETWEEN_CELLS
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
        tgr.isEnabled = true
    }
    
    func subNewMsgNum() {
        
    }
    
    @objc func newMsgTipViewClicked() {
        messageView.contentOffset = CGPoint.zero
        newMsgNum = 0
        newMsgTipView.isHidden = true
        tgr.isEnabled = false
    }
    
    @objc func sendBtnClicked() {
        if textField.text == "" { return }
        NotificationCenter.default.post(name: Notification.Name("sendMessage"), object: self, userInfo: ["type": MsgType.textMsg, "speaker": "我", "text": textField.text!])
        textField.text = ""
    }
    
}

extension ChatBoxView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
