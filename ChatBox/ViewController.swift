//
//  ViewController.swift
//  ChatBox
//
//  Created by 刘菁楷 on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    
    let cbv = ChatBoxView()
    let screenMessageStore = ScreenMessageStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(cbv)
        cbv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: screenWidth * 0.8, height: screenWidth * 1.2))
            make.center.equalToSuperview()
        }
        cbv.messageView.delegate = screenMessageStore
        cbv.messageView.dataSource = screenMessageStore
        
        ceshi()
        
    }
    
    func ceshi() {
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.size.equalTo(80)
        }
        btn.backgroundColor = UIColor.white
        btn.setTitle("增加", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(ccc), for: .touchDown)
    }
    
    @objc func ccc() {
        let nm = Message(type: .newPeopleCome, speaker: "??", text: nil)
        screenMessageStore.addNewMessage(msg: nm)
        cbv.addedNewMessage(text: nm.getString())
    }


}

