//
//  MyBookViewController2.swift
//  Gbbul
//
//  Created by t2023-m0048 on 2023/09/26.
//

import UIKit
import SwiftUI
import CoreData

class MyBookViewController2: BaseViewController {
    private var manager = GbbulManager()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어장 추가하기", fontSize: .large)
        return label
    }()
    
    private lazy var holderLabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어장 이름", fontSize: .medium)
        return label
    }()
    
    private lazy var addButton = {
        let btn = UIButton()
        btn.setUpButton(title: "만들기")
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var textField = {
        let tf = UITextField()
        tf.layer.borderColor = Palette.purple.getColor().cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = true
        tf.placeholder = "나만의 단어장을 추가하세요"
        return tf
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        addSubView()
        makeConstraints()
        textField.delegate = self
        
    }
    
    
    // MARK: - Function
    
    func addSubView(){
        view.addSubview(titleLabel)
        view.addSubview(holderLabel)
        view.addSubview(textField)
        view.addSubview(addButton)
        
    }
    
    func makeConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        holderLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(holderLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaRightMargin.getMargin())
            make.height.equalToSuperview().multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaLeftMargin.getMargin())
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        
    }
    
    
    @objc func addButtonTapped() {
        if let newBookName = textField.text, !newBookName.isEmpty {
            if let bookList = manager.getBook() {
                if bookList.count < 5000 {
                    if let lastBook = bookList.last {
                        let newId = lastBook.bookId + 1
                        manager.createMyBook(name: newBookName, id: Int(newId))
                    } else {
                        manager.createMyBook(name: newBookName, id: 0)
                    }
                } else {
                    print("5000개 넘었습니다.")
                }
            }
        }
        textField.text = ""
        self.navigationController?.popViewController(animated: true)
    }


    
    
}


// MARK: - UITextFieldDelegate
extension MyBookViewController2: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textField {
            self.addButtonTapped()
            textField.text = ""
        }
        return true
    }
    
    
}




// MARK: - Preview

struct VCPreview: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    func makeUIViewController(context: Context) -> UIViewController {
        MyBookViewController2()
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        VCPreview()
    }
}



