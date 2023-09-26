//
//  SignInViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit
import SnapKit

enum LayoutMultiplier: CGFloat {
    case small
    case medium
    func getScale() -> Double {
        switch self{
        case .small:
            return 0.05
        case .medium:
            return 0.6
        }
    }
}


class SignInViewController: BaseViewController {
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "어서오세요", fontSize: .large)
        return titleLabel
    }()
    private lazy var nicknameLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "닉네임", fontSize: .medium)
        return titleLabel
    }()
    private lazy var inputTextField : UITextField = {
        let inputTextField = UITextField()
        inputTextField.setUpTextField()
        inputTextField.placeholder = "닉네임을 입력해주세요."
        return inputTextField
    }()
    private lazy var confirmButton : UIButton = {
        let confirmButton = UIButton()
        confirmButton.setUpButton(title: "시작하기")
        confirmButton.addTarget(self, action: #selector(onConfirmButtonTapped), for: .touchUpInside)
        return confirmButton
    }()
    
    private var manager = GbbulManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
    }
    private func configUI(){
        [titleLabel,nicknameLabel,inputTextField,confirmButton].forEach(view.addSubview)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constMargin.safeAreaTopMargin.getMargin())
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
        }
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-constMargin.safeAreaLeftMargin.getMargin())
            $0.height.equalToSuperview().multipliedBy(LayoutMultiplier.small.getScale())
        }
        confirmButton.snp.makeConstraints {
            $0.centerX.equalTo(inputTextField)
            $0.top.equalTo(inputTextField.snp.bottom).offset(20)
            $0.width.equalTo(inputTextField.snp.width).multipliedBy(LayoutMultiplier.medium.getScale())
            $0.height.equalTo(inputTextField.snp.height)
        }
    }
}
extension SignInViewController{
    @objc func onConfirmButtonTapped() {
        guard let inputTextFieldText = inputTextField.text else{
            showAlert(title: "에러", message: "닉네임이 nil입니다.")
            return
        }
        if inputTextFieldText == "" {
            showAlert(title: "에러", message: "닉네임을 입력해주세요.")
        } else {
            let tabBarController = UITabBarController()
            tabBarController.setupTabBarController()
            present(tabBarController, animated: true)
            
            manager.createUser(name: inputTextFieldText)
        }
    }
}
