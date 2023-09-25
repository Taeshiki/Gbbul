//
//  SceneDelegate.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let isSkip = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if isSkip == true{
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            tabBarController.setupTabBarController()
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }else{
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = SignInViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


extension UITabBarController {
    func setupTabBarController() {
        let bookViewController = BookViewController()
        let myBookViewController = MyBookViewController()
        let myPageViewController = MyPageViewController()
        
        let bookIcon = UIImage(systemName: "play.rectangle")
        bookViewController.tabBarItem = UITabBarItem(title: "단어 공유소", image: bookIcon, tag: 0)
        
        let myBookIcon = UIImage(systemName: "person.crop.rectangle")
        myBookViewController.tabBarItem = UITabBarItem(title: "내 단어장", image: myBookIcon, tag: 1)
        
        let myPageIcon = UIImage(systemName: "person.crop.rectangle")
        myPageViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: myPageIcon, tag: 2)
        
        viewControllers = [bookViewController, myBookViewController, myPageViewController]
        tabBar.tintColor = .black
        
        self.modalPresentationStyle = .fullScreen
    }
}