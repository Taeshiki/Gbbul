//
//  SignInViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit
import SnapKit

enum LayoutMultiplier: CGFloat {
    case superExtraSmall
    case extraSmall
    case quarter
    case medium
    case half
    func getScale() -> Double {
        switch self{
        case .superExtraSmall:
            return 0.02
        case .extraSmall:
            return 0.05
        case .quarter:
            return 0.25
        case .half:
            return 0.5
        case .medium:
            return 0.6
        }
    }
}
class SignInViewController: BaseViewController {
    private lazy var titleLabel : UIButton = {
        let image = UIImage(named: "logo")
        $0.setImage(image, for: .normal)
        $0.setTitleColor(Palette.white.getColor(), for: .normal)
        return $0
    }(UIButton(type: .custom))
    
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
    
    private var manager : GbbulManager!
    init(manager : GbbulManager)
    {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.manager = GbbulManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
    }
    private func configUI(){
        [titleLabel,inputTextField,confirmButton].forEach(view.addSubview)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(inputTextField.snp.top).offset(-ConstMargin.safeAreaBottomMargin.getMargin())
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaLeftMargin.getMargin())
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
        }
        inputTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.height.equalToSuperview().multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        confirmButton.snp.makeConstraints {
            $0.centerX.equalTo(inputTextField)
            $0.top.equalTo(inputTextField.snp.bottom).offset(20)
            $0.height.equalTo(inputTextField.snp.height)
            $0.width.equalTo(inputTextField.snp.width)
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
