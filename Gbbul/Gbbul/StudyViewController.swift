//
//  StudyViewController.swift
//  Gbbul
//
//  Created by Jooyeon Kang on 2023/09/26.
//

import UIKit

class StudyViewController: BaseViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어장 학습하기", fontSize: .large)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어 뜻을 아시나요?", fontSize: .medium)
        return label
    }()
    
    private lazy var vocaView: UIView = {
       let view = UIView()
        // 색깔 어떻게 할까..?? 버튼이랑 같은 느낌으로 갈까..
        view.backgroundColor = Palette.pink.getColor()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupSubTitleLabel()
        setupVocaView()
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
    
    func setupVocaView() {
        view.addSubview(vocaView)
        
        vocaView.snp.makeConstraints { make in
            //?? 마진값 어떻게 할까용
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(view.frame.width - constMargin.safeAreaLeftMargin.getMargin() - constMargin.safeAreaRightMargin.getMargin())
        }
        
        let vocaLabel = UILabel()
        vocaLabel.setUpLabel(title: "테스트 중", fontSize: .medium)
        
        vocaView.addSubview(vocaLabel)
        
        vocaLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
