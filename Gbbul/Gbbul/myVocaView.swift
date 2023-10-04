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
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let titleTextField: UITextField = {
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textAlignment = .left
        $0.borderStyle = .none
        $0.textColor = Palette.purple.getColor()
        $0.isUserInteractionEnabled = false
        return $0
    }(UITextField())
    
    let editButton: UIButton = {
        let image = UIImage(systemName: "pencil.circle.fill")
        let resizedImage = $0.resizeImageButton(image: image, width: 60, height: 60, color: Palette.boldPink.getColor())
        $0.setImage(resizedImage, for: .normal)
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
        let image = UIImage(systemName: "plus.circle")
        let resizedImage = $0.resizeImageButton(image: image, width: 60, height: 60, color: Palette.boldPink.getColor())
        $0.setImage(resizedImage, for: .normal)
        $0.tintColor = Palette.purple.getColor()
        $0.setTitleColor(Palette.white.getColor(), for: .normal)
        return $0
    }(UIButton(type: .custom))
    
    let vocaTableView: UITableView = {
        $0.setUpTableView(borderColor : .purple)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setconstraints()
        setTableView()
        setButtonTarget()
        setTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTableView()
    }
    
    func setUI() {
        view.addSubview(titleTextField)
        view.addSubview(editButton)
        view.addSubview(floatingButton)
        view.addSubview(vocaTableView)
        view.addSubview(hiddenLabel)
        view.addSubview(learnButton)
        
        titleTextField.text = selectedBookTitle
    }
    
    func setconstraints() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-ConstMargin.safeAreaRightMargin.getMargin())
            $0.height.equalTo(40)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(floatingButton.snp.top)
            $0.right.equalTo(floatingButton.snp.left).offset(-10)
            
        }
        
        floatingButton.snp.makeConstraints {
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.width.height.equalTo(60)
        }
        
        vocaTableView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(learnButton.snp.top).offset(-20)
        
        }
        
        hiddenLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().offset(20)
        }
        
        learnButton.snp.makeConstraints {
            $0.bottom.equalTo(floatingButton.snp.top).offset(-20)
            $0.width.equalTo(vocaTableView.snp.width)
            $0.height.equalTo(40)
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
        
        vocaTableView.reloadData()
    }
    
    func setButtonTarget() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func setTapGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.isEnabled = false
    }
    
    func setTextField() {
        tapGestureRecognizer.isEnabled = true
        
        titleTextField.isUserInteractionEnabled = true
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = Palette.purple.getColor().cgColor
        titleTextField.layer.cornerRadius = 10
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
    
    @objc func editButtonTapped() {
        setTextField()
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        titleTextField.isUserInteractionEnabled = false
        titleTextField.borderStyle = .none
        titleTextField.layer.borderWidth = 0
        
        guard let newTitle = titleTextField.text, !newTitle.trimmingCharacters(in: .whitespaces).isEmpty, let bookId = selectedBookId else {
            let alertController = UIAlertController(title: "알림", message: "수정할 단어장 제목을 입력하세요.", preferredStyle: .alert)
            alertController.view.tintColor = Palette.purple.getColor()
            
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            setTextField()
            return
        }
        gbbulManager.updateMyBookName(newBookName: newTitle, selectedBookId: bookId)
        
        tapGestureRecognizer.isEnabled = false
    }
}

extension myVocaView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let myVocaToDelete = vocabularyData[indexPath.row]
            gbbulManager.deleteMyVoca(myVoca: myVocaToDelete)
            
            vocabularyData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVoca = vocabularyData[indexPath.row]
        
        let alertController = UIAlertController(title: "단어 수정", message: "단어와 의미를 수정해 주세요.", preferredStyle: .alert)
        alertController.view.tintColor = Palette.purple.getColor()
        
        alertController.addTextField { (textField) in
            textField.text = selectedVoca.myVocaName
            textField.placeholder = "단어"
        }
        alertController.addTextField { (textField) in
            textField.text = selectedVoca.myVocaMean
            textField.placeholder = "의미"
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let newName = alertController.textFields?[0].text,
                  let newMean = alertController.textFields?[1].text,
                  !newName.trimmingCharacters(in: .whitespaces).isEmpty,
                  !newMean.trimmingCharacters(in: .whitespaces).isEmpty else {
                
                alertController.textFields?[0].placeholder = "단어를 입력해 주세요."
                alertController.textFields?[1].placeholder = "의미를 입력해 주세요."
                
                self.present(alertController, animated: true)
                
                return
            }
            
            selectedVoca.setValue(newName, forKey: "myVocaName")
            selectedVoca.setValue(newMean, forKey: "myVocaMean")
            self.gbbulManager.saveContext()
            self.vocaTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.vocaTableView.reloadData()
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
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
