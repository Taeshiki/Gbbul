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
        if isSkip{
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            tabBarController.setupTabBarController()
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }else{
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = SignInViewController(manager: GbbulManager())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


extension UITabBarController {
    func setupTabBarController() {
        let bookViewController = BookViewController()
        let myBookViewController = MyBookViewController()
        let myPageViewController = MyPageViewController(manager: GbbulManager())
        
        let bookIcon = UIImage(systemName: "book.circle")
        bookViewController.tabBarItem = UITabBarItem(title: "단어 공유소", image: bookIcon, tag: 0)
        
        let myBookIcon = UIImage(systemName: "book.circle.fill")
        myBookViewController.tabBarItem = UITabBarItem(title: "내 단어장", image: myBookIcon, tag: 1)
        
        let myPageIcon = UIImage(systemName: "person.circle")
        myPageViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: myPageIcon, tag: 2)
        
        viewControllers = [bookViewController, myBookViewController, myPageViewController]
        tabBar.tintColor = .black
        
        self.modalPresentationStyle = .fullScreen
    }
}
