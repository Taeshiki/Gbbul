//
//  SignInViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "book") 
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(showTabBarController), for: .touchUpInside)
        let buttonSize = CGSize(width: 100, height: 100)
        button.frame.size = buttonSize
        button.center = view.center
        view.addSubview(button)
    }
    @objc func showTabBarController() {
        let tabBarController = UITabBarController()
        tabBarController.setupTabBarController()
        present(tabBarController, animated: true)
        UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
    }
}
