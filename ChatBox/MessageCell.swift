//
//  MessageCell.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit
import SnapKit

class MessageCell: UICollectionViewCell {
    
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // 当然cell也要翻转
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        contentView.backgroundColor = #colorLiteral(red: 0.6125292182, green: 0.8968527913, blue: 0.9713204503, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.addSubview(textLabel)
        textLabel.backgroundColor = .clear
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(PADDING_OF_TEXT_H)
            make.trailing.equalTo(-PADDING_OF_TEXT_H)
            make.center.equalToSuperview()
        }
        textLabel.font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        textLabel.numberOfLines = 0
    }
    
    func setupCell(text: String) {
        textLabel.text = text
        textLabel.sizeToFit()
    }
    
}
