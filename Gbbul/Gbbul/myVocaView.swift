//
//  myVocaView.swift
//  Gbbul
//
//  Created by Kyle on 2023/09/26.
//

import UIKit
import SnapKit
import CoreData

class myVocaView: BaseViewController {
    
    var vocabularyData: [MyVoca] = []
    var gbbulManager = GbbulManager()
    var selectedBookTitle: String?
    var selectedBookId: Int64?
    
    let titleLabel: UILabel = {
        $0.setUpLabel(title: "", fontSize: .large)
        return $0
    }(UILabel())
    
    let titleTextField: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 16)
        //$0.backgroundColor = .yellow
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.isUserInteractionEnabled = false // 초기에는 수정 불가능하도록 설정
        return $0
    }(UITextField())

    let editButton: UIButton = {
        let image = UIImage(systemName: "pencil.circle.fill")
        let resizedImage = $0.resizeImageButton(image: image, width: 60, height: 60, color: Palette.purple.getColor())
        $0.setImage(resizedImage, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.tintColor = Palette.purple.getColor()
        $0.setTitleColor(Palette.white.getColor(), for: .normal)
        return $0
    }(UIButton(type: .custom))
    
    let hiddenLabel: UILabel = {
        $0.setUpLabel(title: "단어를 추가 해주세요.", fontSize: .medium)
        return $0
    }(UILabel())
    
    let learnButton: UIButton = {
        $0.setUpButton(title: "학습하기")
        return $0
    }(UIButton())
    
    let floatingButton: UIButton = {
        $0.setTitle("+", for: .normal)
        $0.backgroundColor = Palette.pink.getColor()
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .custom))
    
    let vocaTableView: UITableView = {
        $0.setUpTableView()
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setconstraints()
        setTableView()
        setButtonTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTableView()
        vocabularyData = gbbulManager.getMyVoca(by: selectedBookId!) ?? []
        vocaTableView.reloadData()
    }
    
    func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(editButton)
        view.addSubview(floatingButton)
        view.addSubview(vocaTableView)
        view.addSubview(hiddenLabel)
        view.addSubview(learnButton)
        
        titleLabel.text = selectedBookTitle
    }
    
    func setconstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-ConstMargin.safeAreaRightMargin.getMargin())
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-ConstMargin.safeAreaRightMargin.getMargin())
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(floatingButton.snp.top)
            $0.right.equalTo(floatingButton.snp.left).offset(-10)
            $0.width.height.equalTo(60)
        }
        
        floatingButton.snp.makeConstraints {
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.width.height.equalTo(60)
        }
        
        vocaTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(learnButton.snp.top).offset(-20)
        }
        
        hiddenLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().offset(20)
        }
        
        learnButton.snp.makeConstraints {
            $0.bottom.equalTo(floatingButton.snp.top).offset(-20)
            $0.width.equalTo(180)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setTableView() {
        if let bookId = selectedBookId {
            vocabularyData = gbbulManager.getMyVoca(by: bookId) ?? []
        }
        
        vocaTableView.delegate = self
        vocaTableView.dataSource = self
        
        if vocabularyData.isEmpty {
            hiddenLabel.isHidden = false
            vocaTableView.isHidden = true
            learnButton.isHidden = true
        } else {
            hiddenLabel.isHidden = true
            vocaTableView.isHidden = false
            learnButton.isHidden = false
        }
    }
    
    func setButtonTarget() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        let vocaView2 = myVocaView2()
        
        vocaView2.selectedBookId = selectedBookId
        self.navigationController?.pushViewController(vocaView2, animated: true)
    }
    
    @objc func learnButtonTapped() {
        let studyViewController = StudyViewController()
        studyViewController.bookId = selectedBookId
        navigationController?.pushViewController(studyViewController, animated: false)
    }
    
    
    @objc func editButtonTapped(){
        
        print("에딧버튼눌림")
    }
}




extension myVocaView: UITableViewDelegate {
    
}

extension myVocaView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabularyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let myVoca = vocabularyData[indexPath.row]
        cell.textLabel?.text = myVoca.myVocaName
        cell.detailTextLabel?.text = myVoca.myVocaMean
        
        return cell
    }
}
