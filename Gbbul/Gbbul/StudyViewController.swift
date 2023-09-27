//
//  StudyViewController.swift
//  Gbbul
//
//  Created by Jooyeon Kang on 2023/09/26.
//

import UIKit

struct TestVoca {
    var name: String
    var mean: String
}

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
    
    private lazy var vocaStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    // MARK: - 변수
    var manager = GbbulManager()
    
    var bookId: Int64?
    
    var testVocaList: [TestVoca] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupSubTitleLabel()
        setupVocaStackView()
    }
    
    // MARK: - UI Setup
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
    
    func setupVocaStackView() {
        view.addSubview(vocaStackView)
        
        vocaStackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(view.frame.width
                                      - ConstMargin.safeAreaLeftMargin.getMargin()
                                      - ConstMargin.safeAreaRightMargin.getMargin())
            
            getTestVocaList()
            
            for i in testVocaList {
                addVocaView(name: i.name)
            }
        }
    }
}

// MARK: - CoreData 관련
extension StudyViewController {
    
    // MARK: 매니저에서 불러오는 함수 지금 틀렸으니까 나중에 수정 반드시 할 것!!!
    func getTestVocaList() {
        testVocaList = []
        guard let bookId = bookId else { return }
        
        // MyVoca
        if bookId <= 5000 {
            guard let myVocaList = manager.getMyVoca(by: bookId) else { return }
            for i in myVocaList {
                if let name = i.myVocaName, let mean = i.myVocaMean {
                    testVocaList.append(TestVoca(name: name, mean: mean))
                }
            }
            
        // Voca
        } else if bookId > 5000 {
            guard let vocaList = manager.getVoca(by: bookId) else { return }
            for i in vocaList {
                if let name = i.vocaName, let mean = i.vocaMean {
                    testVocaList.append(TestVoca(name: name, mean: mean))
                }
            }
        }
        
        for i in 0..<testVocaList.count {
            let newIndex = Int.random(in: i..<testVocaList.count)
            testVocaList.swapAt(i, newIndex)
        }
    }
}

// MARK: - 단어 view 관련
extension StudyViewController {
    func addVocaView(name: String) {
        let vocaView = UIView()
        vocaView.backgroundColor = Palette.pink.getColor()
        
        let vocaLabel = UILabel()
        vocaLabel.setUpLabel(title: name, fontSize: .medium)
        
        vocaView.addSubview(vocaLabel)
        vocaStackView.addArrangedSubview(vocaView)
        
        vocaView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        vocaLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        vocaView.addGestureRecognizer(gesture)
    }
    
    // MARK: 단어 view 넘기는 함수
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        // 움직일 view = vocaView
        guard let vocaView = sender.view else { return }

        // 지정된 뷰를 기준으로 사용자가 드래그한 거리를 반환
        let point = sender.translation(in: vocaView)
        
        // 부모뷰의 중심
        let centerOfSuperView = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        
        // vocaView를 움직일 때마다 부모뷰의 중심을 통해, 이동 된 vocaView의 중심을 구함
        vocaView.center = CGPoint(x: centerOfSuperView.x + point.x, y: centerOfSuperView.y + point.y)
        
        switch sender.state {
            
            // 제스처 멈췄을 때, 숫자값은 테스트를 통해 적당한 값을 임의로 설정
        case .ended:
            // 오른쪽
            if (vocaView.center.x) > 20 {
                UIView.animate(withDuration: 0.2) {
                    vocaView.center = CGPoint(x: vocaView.center.x,
                                          y: vocaView.center.y)
                    vocaView.alpha = 0
                }
                
            // 왼쪽
            } else if vocaView.center.x < -20 {
                UIView.animate(withDuration: 0.2) {
                    vocaView.center = CGPoint(x: vocaView.center.x,
                                          y: vocaView.center.y)
                    vocaView.alpha = 0
                }

            // 위의 값이 아닌 곳에서 제스처를 멈췄을 때는 view를 중앙으로 다시 이동
            } else {
                UIView.animate(withDuration: 0.2) {
                    vocaView.transform = .identity
                    vocaView.center = CGPoint(x: self.view.frame.width / 2,
                                          y: self.view.frame.height / 2)
                }
            }
            
            vocaStackView.removeArrangedSubview(vocaView)
            
            if vocaStackView.arrangedSubviews.count == 0 {
                showAlertTwoButton(title: "학습을 완료했습니다", message: nil, button1Title: "재시험", button2Title: "확인", completion1: {
                    self.getTestVocaList()
                    
                    for i in self.testVocaList {
                        self.addVocaView(name: i.name)
                    }
                    
                    self.view.layoutIfNeeded()
                }, completion2: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
            
        // 제스처가 움직이고 있을 때, 비스듬하게
        case .changed:
            let rotation = point.x / view.frame.width
            vocaView.transform = CGAffineTransform(rotationAngle: -rotation)
            
        default:
            break
        }
    }
}
