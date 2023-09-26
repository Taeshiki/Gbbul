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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalToSuperview().offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
    }
    
    func setupSubTitleLabel() {
        view.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    func setupVocaView() {
        view.addSubview(vocaView)
        
        vocaView.snp.makeConstraints { make in
            //?? 마진값 어떻게 할까용
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(view.frame.width - ConstMargin.safeAreaLeftMargin.getMargin() - ConstMargin.safeAreaRightMargin.getMargin())
        }
        
        let vocaLabel = UILabel()
        vocaLabel.setUpLabel(title: "테스트 중", fontSize: .medium)
        
        vocaView.addSubview(vocaLabel)
        
        vocaLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        vocaView.addGestureRecognizer(gesture)
    }
    
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        // 움직일 view = vocaView
        guard let voca = sender.view else { return }

        // 지정된 뷰를 기준으로 사용자가 드래그한 거리를 반환
        let point = sender.translation(in: voca)
        
        // 부모뷰의 중심
        let centerOfSuperView = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        
        // vocaView를 움직일 때마다 부모뷰의 중심을 통해, 이동 된 vocaView의 중심을 구함
        voca.center = CGPoint(x: centerOfSuperView.x + point.x, y: centerOfSuperView.y + point.y)
        
        switch sender.state {
            
            // 제스처 멈췄을 때, 숫자값은 테스트를 통해 적당한 값을 임의로 설정
        case .ended:
            // 오른쪽
            if (voca.center.x) > 20 {
                UIView.animate(withDuration: 0.2) {
                    voca.center = CGPoint(x: voca.center .x,
                                          y: voca.center .y)
                    voca.alpha = 0
                }
                
            // 왼쪽
            } else if voca.center.x < -20 {
                UIView.animate(withDuration: 0.2) {
                    voca.center = CGPoint(x: voca.center .x,
                                          y: voca.center .y)
                    voca.alpha = 0
                }

            // 위의 값이 아닌 곳에서 제스처를 멈췄을 때는 view를 중앙으로 다시 이동
            } else {
                UIView.animate(withDuration: 0.2) {
                    voca.transform = .identity
                    voca.center = CGPoint(x: self.view.frame.width / 2,
                                          y: self.view.frame.height / 2)
                }
            }

        // 제스처가 움직이고 있을 때, 비스듬하게
        case .changed:
            let rotation = point.x / view.frame.width
            voca.transform = CGAffineTransform(rotationAngle: -rotation)
            
        default:
            break
        }
    }
}
