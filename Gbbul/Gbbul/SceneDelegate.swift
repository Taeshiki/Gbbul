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
            //여기서 한번만 불리는 친구들 정말 최초에 한번만
            //함수 만들기 
            let gbbulManager = GbbulManager()

            //gbbulManager.createBook(bookId: 5001, bookName: "기초 영어단어 10")
            gbbulManager.createBook(bookName: "기초 영어단어 20", bookId: 5002)
            gbbulManager.createBook(bookName: "기초 영어단어 30", bookId: 5003)
            gbbulManager.createBook(bookName: "기초 영어단어 40", bookId: 5004)
            gbbulManager.createBook(bookName: "기초 영어단어 50", bookId: 5005)
            gbbulManager.createBook(bookName: "기초 영어단어 60", bookId: 5006)
            gbbulManager.createBook(bookName: "기초 영어단어 70", bookId: 5007)
            gbbulManager.createBook(bookName: "기초 영어단어 80", bookId: 5008)
            gbbulManager.createBook(bookName: "기초 영어단어 90", bookId: 5009)
            gbbulManager.createBook(bookName: "기초 영어단어 100", bookId: 5010)

            gbbulManager.createVoca(bookId: 5001, vocaName: "culture", vocaMean: "문화")
            gbbulManager.createVoca(bookId: 5001, vocaName: "experience", vocaMean: "경험")
            gbbulManager.createVoca(bookId: 5001, vocaName: "education", vocaMean: "교육")
            gbbulManager.createVoca(bookId: 5001, vocaName: "symbol", vocaMean: "상징")
            gbbulManager.createVoca(bookId: 5001, vocaName: "effect", vocaMean: "결과, 영향, 효과")

            gbbulManager.createVoca(bookId: 5002, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5002, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5002, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5002, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5002, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5003, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5003, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5003, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5003, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5003, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5004, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5004, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5004, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5004, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5004, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5005, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5005, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5005, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5005, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5005, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5006, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5006, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5006, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5006, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5006, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5007, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5007, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5007, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5007, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5007, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5008, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5008, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5008, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5008, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5008, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5009, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5009, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5009, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5009, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5009, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5010, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5010, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5010, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5010, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5010, vocaName: "subject", vocaMean: "학과, 주제")
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
        
        let bookNavController = UINavigationController(rootViewController: bookViewController)
        let myBookNavController = UINavigationController(rootViewController: myBookViewController)
        let myPageNavController = UINavigationController(rootViewController: myPageViewController)

        viewControllers = [bookNavController, myBookNavController, myPageNavController]
        tabBar.tintColor = .black
        
        self.modalPresentationStyle = .fullScreen
    }
}
