//
//  StudyViewController.swift
//  Gbbul
//
//  Created by Jooyeon Kang on 2023/09/26.
//

import UIKit

class StudyViewController: BaseViewController {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어장 학습하기", fontSize: .large)
        return label
    }()
    
    private lazy var subTitleLabel : UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어 뜻을 아시나요?", fontSize: .medium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupSubTitleLabel()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constMargin.safeAreaTopMargin.getMargin())
            make.leading.equalToSuperview().offset(constMargin.safeAreaLeftMargin.getMargin())
        }
    }
    
    func setupSubTitleLabel() {
        view.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
}
