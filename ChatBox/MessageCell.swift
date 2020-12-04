//
//  MessageCell.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit
import SnapKit
import AVFoundation

class MessageCell: UICollectionViewCell {
    
    var audioPlayer: AVAudioPlayer!
    var videoPlayer: AVPlayer!
    var videoPlayerLayer = AVPlayerLayer()
    
    let textLabel = UILabel()
    let imageView = UIImageView()
    let audioButton = UIButton()
    let container = UIView() // 用于承载视频
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        audioPlayer = nil
        textLabel.text = ""
        imageView.image = nil
        
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
            make.top.equalTo(PADDING_OF_TEXT_V)
        }
        textLabel.font = UIFont.systemFont(ofSize: TEXT_FONT_SIZE)
        textLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel.numberOfLines = 0
        
        contentView.addSubview(imageView)
        imageView.backgroundColor = .clear
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(PADDING_OF_TEXT_H)
            make.trailing.equalTo(-PADDING_OF_TEXT_H)
            make.top.equalTo(textLabel.snp.bottom)
            make.bottom.equalTo(-PADDING_OF_TEXT_V)
        }
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(audioButton)
        audioButton.backgroundColor = .clear
        audioButton.snp.makeConstraints { make in
            make.leading.equalTo(PADDING_OF_TEXT_H)
            make.trailing.equalTo(-PADDING_OF_TEXT_H)
            make.top.equalTo(textLabel.snp.bottom)
            make.bottom.equalTo(-PADDING_OF_TEXT_V)
        }
        audioButton.setImage(UIImage(named: "audio"), for: .normal)
        audioButton.imageView?.contentMode = .scaleAspectFit
        audioButton.addTarget(self, action: #selector(audioClicked), for: .touchUpInside)
        
        contentView.addSubview(container)
        container.backgroundColor = .clear
        container.snp.makeConstraints { make in
            make.leading.equalTo(PADDING_OF_TEXT_H)
            make.trailing.equalTo(-PADDING_OF_TEXT_H)
            make.top.equalTo(textLabel.snp.bottom)
            make.bottom.equalTo(-PADDING_OF_TEXT_V)
        }
        container.layer.addSublayer(videoPlayerLayer)
    }
    
    func setupCell(message: Message) {
        textLabel.text = message.getString()
        textLabel.sizeToFit()
        
        if let data = message.imageData {
            imageView.image = UIImage(data: data)
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        if let data = message.audioData {
            do {
                try audioPlayer = AVAudioPlayer(data: data)
                audioButton.isHidden = false
                audioButton.isEnabled = true
            } catch { }
        } else {
            audioButton.isHidden = true
            audioButton.isEnabled = false
        }
        
        if let url = message.videoUrl {
            DispatchQueue.main.async {
                self.videoPlayerLayer.frame = self.container.bounds
            }
            videoPlayer = AVPlayer(url: url)
            videoPlayerLayer.player = videoPlayer
            videoPlayerLayer.isHidden = false
            videoPlayer.play()
        } else {
            videoPlayerLayer.isHidden = true
        }
    }
    
    @objc func audioClicked() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        } else {
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = 0
            audioPlayer.play()
        }
    }
    
}
