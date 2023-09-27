//
//  myVocaView2.swift
//  Gbbul
//
//  Created by Kyle on 2023/09/26.
//

import UIKit
import SnapKit
import CoreData

class myVocaView2: BaseViewController {

    let titleLabel: UILabel = {
        $0.setUpLabel(title: "단어 추가하기", fontSize: .large)
        return $0
    }(UILabel())
    
    let vocaNameLabel: UILabel = {
        $0.setUpLabel(title: "단어", fontSize: .medium)
        return $0
    }(UILabel())
    
    let vocaMeanLabel: UILabel = {
        $0.setUpLabel(title: "의미", fontSize: .medium)
        return $0
    }(UILabel())
    
    let vocaNameTextField: UITextField = {
        $0.setUpTextField()
        return $0
    }(UITextField())
    
    let vocaMeanTextField: UITextField = {
        $0.setUpTextField()
        return $0
    }(UITextField())
    
    let addButton: UIButton = {
        $0.setUpButton(title: "추가하기")
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setConstraints()
        setButtonTarget()
    }

    func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(vocaNameTextField)
        view.addSubview(vocaMeanTextField)
        view.addSubview(addButton)
        view.addSubview(vocaNameLabel)
        view.addSubview(vocaMeanLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(ConstMargin.safeAreaRightMargin.getMargin())
        }
        
        vocaNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        vocaNameTextField.snp.makeConstraints {
            $0.top.equalTo(vocaNameLabel.snp.bottom).offset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-ConstMargin.safeAreaRightMargin.getMargin())
            $0.height.equalTo(40)
        }
        
        vocaMeanLabel.snp.makeConstraints {
            $0.top.equalTo(vocaNameTextField.snp.bottom).offset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        vocaMeanTextField.snp.makeConstraints {
            $0.top.equalTo(vocaMeanLabel.snp.bottom).offset(20)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-ConstMargin.safeAreaRightMargin.getMargin())
            $0.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(vocaMeanTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
        }
    }
    
    func setButtonTarget() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
       
    }
}
