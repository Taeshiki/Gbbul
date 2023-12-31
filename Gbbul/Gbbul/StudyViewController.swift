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
    
    // MARK: - UI Component
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
    
    private lazy var correctLabel: UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "알아요 →", fontSize: .large)
        label.isHidden = true
        let rotation: CGFloat = CGFloat.pi / 4
        label.transform = CGAffineTransform(rotationAngle: rotation)
        return label
    }()
    
    private lazy var incorrectLabel: UILabel = {
        let label = UILabel()
        label.setUpLabel(title: "← 몰라요", fontSize: .large)
        label.isHidden = true
        let rotation: CGFloat = CGFloat.pi / 4
        label.transform = CGAffineTransform(rotationAngle: -rotation)
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
    
    var correctCount: Double = 0
    var incorrectCount: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupSubTitleLabel()
        setupVocaStackView()
        setupIncorrectLabel()
        setupCorrectLabel()
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
            make.top.equalTo(subTitleLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.frame.width
                                - ConstMargin.safeAreaLeftMargin.getMargin()
                                - ConstMargin.safeAreaRightMargin.getMargin())
            make.width.equalTo(vocaStackView.snp.height).multipliedBy(0.6)
        }
        
        getTestVocaList()
        
        for i in testVocaList {
            addVocaView(name: i.name)
        }
    }
    
    func setupCorrectLabel() {
        view.addSubview(correctLabel)
        
        correctLabel.snp.makeConstraints { make in
            make.bottom.equalTo(vocaStackView.snp.top)
            make.leading.equalTo(vocaStackView.snp.trailing)
        }
    }
    
    func setupIncorrectLabel() {
        view.addSubview(incorrectLabel)
        
        incorrectLabel.snp.makeConstraints { make in
            make.bottom.equalTo(vocaStackView.snp.top)
            make.trailing.equalTo(vocaStackView.snp.leading)
        }
    }
}

// MARK: - CoreData 관련
extension StudyViewController {
    
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
        vocaView.layer.cornerRadius = 15
        vocaView.layer.shadowColor = Palette.gray.getColor().cgColor
        vocaView.layer.shadowOffset = CGSize(width: 2, height: 2)
        vocaView.layer.shadowOpacity = 0.2
        vocaView.layer.shadowRadius = 4.0
        
        let vocaLabel = UILabel()
        vocaLabel.setUpLabel(title: name, fontSize: .medium, titleColor: .lightGray)
        vocaLabel.numberOfLines = 0
        vocaLabel.textAlignment = .center
        
        vocaView.addSubview(vocaLabel)
        vocaStackView.addArrangedSubview(vocaView)
        
        vocaView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        vocaLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        vocaView.addGestureRecognizer(gesture)
    }
    
    // MARK: 단어 view 넘기는 함수
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let vocaView = sender.view else { return }
        let point = sender.translation(in: vocaView)
        let centerOfVocaView = CGPoint(x: vocaView.frame.width / 2, y: vocaView.frame.height / 2)
        vocaView.center = CGPoint(x: centerOfVocaView.x + point.x, y: centerOfVocaView.y)
        
        switch sender.state {
        case .ended:
            // 오른쪽
            if (vocaView.center.x) > 200 {
                UIView.animate(withDuration: 0.2) {
                    vocaView.center = CGPoint(x: vocaView.center.x, y: vocaView.center.y)
                    self.correctLabel.isHidden = true
                    self.correctCount += 1
                    self.remove(to: vocaView)
                }
                
            // 왼쪽
            } else if vocaView.center.x < 100 {
                UIView.animate(withDuration: 0.2) {
                    vocaView.center = CGPoint(x: vocaView.center.x, y: vocaView.center.y)
                    self.incorrectLabel.isHidden = true
                    self.incorrectCount += 1
                    self.remove(to: vocaView)
                }
                
            } else {
                UIView.animate(withDuration: 0.2) {
                    vocaView.transform = .identity
                    vocaView.center = centerOfVocaView
                    self.correctLabel.isHidden = true
                    self.incorrectLabel.isHidden = true
                }
            }
            
        case .changed:
            let rotation = point.x / vocaView.frame.width
            vocaView.transform = CGAffineTransform(rotationAngle: rotation)
            
            if point.x > 0 {
                correctLabel.isHidden = false
            } else if point.x < 0 {
                incorrectLabel.isHidden = false
            }
            
        default:
            break
        }
    }
    
    func remove(to vocaView: UIView) {
        vocaView.alpha = 0
        vocaStackView.removeArrangedSubview(vocaView)
        
        if vocaStackView.arrangedSubviews.count == 0 {

            let total: Double = correctCount + incorrectCount
            let rate: Double = correctCount == 0.0 ? 0.0 : (correctCount / total * 100)

            let message = """
                        정답 : \(Int(correctCount)) 개
                        오답 : \(Int(incorrectCount)) 개
                        정답률 : \(Int(rate)) %
                        """
            showAlertTwoButton(title: "학습을 완료했습니다", message: message, button1Title: "재시험", button2Title: "확인", completion1: {
                self.correctCount = 0
                self.incorrectCount = 0
                
                self.getTestVocaList()
                
                for i in self.testVocaList {
                    self.addVocaView(name: i.name)
                }
                
                self.view.layoutIfNeeded()
            }, completion2: {
                self.navigationController?.popToRootViewController(animated: true)
            })
            
            addCorrectRate()
        }
        
        correctLabel.isHidden = true
        incorrectLabel.isHidden = true
    }
    
    func addCorrectRate() {
        guard let bookId: Int64 = bookId else { return }
        let total: Double = correctCount + incorrectCount
        let rate: Double = correctCount == 0.0 ? 0.0 : (correctCount / total * 100)
        
        manager.createCorrectRate(by: bookId,
                                  correct: Int(correctCount),
                                  incorrect: Int(incorrectCount),
                                  rate: rate,
                                  total: Int(total))
    }
}
