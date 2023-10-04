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

            gbbulManager.createBook(bookName: "기초 영어단어 Part.1", bookId: 5001)
            gbbulManager.createBook(bookName: "기초 영어단어 Part.2", bookId: 5002)
            gbbulManager.createBook(bookName: "기초 영어단어 Part.3", bookId: 5003)
            gbbulManager.createBook(bookName: "기초 영어단어 Part.4", bookId: 5004)
            gbbulManager.createBook(bookName: "기초 영어단어 Part.5", bookId: 5005)
            gbbulManager.createBook(bookName: "미국인이 가장 많이쓰는 문장 10", bookId: 5006)
            gbbulManager.createBook(bookName: "미국인이 가장 많이쓰는 문장 15", bookId: 5007)
            gbbulManager.createBook(bookName: "나만 볼 프로그래밍 단어 Part.1", bookId: 5008)
            gbbulManager.createBook(bookName: "나만 볼 프로그래밍 단어 Part.2", bookId: 5009)

            gbbulManager.createVoca(bookId: 5001, vocaName: "culture", vocaMean: "문화")
            gbbulManager.createVoca(bookId: 5001, vocaName: "experience", vocaMean: "경험")
            gbbulManager.createVoca(bookId: 5001, vocaName: "education", vocaMean: "교육")
            gbbulManager.createVoca(bookId: 5001, vocaName: "symbol", vocaMean: "상징")
            gbbulManager.createVoca(bookId: 5001, vocaName: "effect", vocaMean: "결과, 영향, 효과")
            gbbulManager.createVoca(bookId: 5001, vocaName: "liberty", vocaMean: "자유")
            gbbulManager.createVoca(bookId: 5001, vocaName: "affair", vocaMean: "사건")
            gbbulManager.createVoca(bookId: 5001, vocaName: "comfort", vocaMean: "안락, 위안")
            gbbulManager.createVoca(bookId: 5001, vocaName: "tradition", vocaMean: "전통")
            gbbulManager.createVoca(bookId: 5001, vocaName: "subject", vocaMean: "학과, 주제")
            
            gbbulManager.createVoca(bookId: 5002, vocaName: "object", vocaMean: "사물")
            gbbulManager.createVoca(bookId: 5002, vocaName: "source", vocaMean: "출처")
            gbbulManager.createVoca(bookId: 5002, vocaName: "revolution", vocaMean: "혁명")
            gbbulManager.createVoca(bookId: 5002, vocaName: "pollution", vocaMean: "오염")
            gbbulManager.createVoca(bookId: 5002, vocaName: "system", vocaMean: "조직, 체계, 지도")
            gbbulManager.createVoca(bookId: 5002, vocaName: "triumph", vocaMean: "승리")
            gbbulManager.createVoca(bookId: 5002, vocaName: "respect", vocaMean: "존경")
            gbbulManager.createVoca(bookId: 5002, vocaName: "communication", vocaMean: "전달")
            gbbulManager.createVoca(bookId: 5002, vocaName: "foundation", vocaMean: "기초")
            gbbulManager.createVoca(bookId: 5002, vocaName: "glory", vocaMean: "영광")
            
            gbbulManager.createVoca(bookId: 5002, vocaName: "situation", vocaMean: "위치")
            gbbulManager.createVoca(bookId: 5002, vocaName: "competition", vocaMean: "경쟁")
            gbbulManager.createVoca(bookId: 5002, vocaName: "prairie", vocaMean: "대초원")
            gbbulManager.createVoca(bookId: 5002, vocaName: "effort", vocaMean: "노력")
            gbbulManager.createVoca(bookId: 5002, vocaName: "section", vocaMean: "부분")
            
            gbbulManager.createVoca(bookId: 5003, vocaName: "rein", vocaMean: "고삐")
            gbbulManager.createVoca(bookId: 5003, vocaName: "solution", vocaMean: "해결")
            gbbulManager.createVoca(bookId: 5003, vocaName: "unity", vocaMean: "일치")
            gbbulManager.createVoca(bookId: 5003, vocaName: "population", vocaMean: "인구")
            gbbulManager.createVoca(bookId: 5003, vocaName: "direction", vocaMean: "방향")
            gbbulManager.createVoca(bookId: 5003, vocaName: "dialog", vocaMean: "대화")
            gbbulManager.createVoca(bookId: 5003, vocaName: "republic", vocaMean: "공화국")
            gbbulManager.createVoca(bookId: 5003, vocaName: "increase", vocaMean: "증가")
            gbbulManager.createVoca(bookId: 5003, vocaName: "decrease", vocaMean: "감소")
            gbbulManager.createVoca(bookId: 5003, vocaName: "amount", vocaMean: "양, 총계")
            
            gbbulManager.createVoca(bookId: 5004, vocaName: "ancestor", vocaMean: "조상")
            gbbulManager.createVoca(bookId: 5004, vocaName: "voyage", vocaMean: "항해")
            gbbulManager.createVoca(bookId: 5004, vocaName: "sculpture", vocaMean: "조각")
            gbbulManager.createVoca(bookId: 5004, vocaName: "instrument", vocaMean: "도구")
            gbbulManager.createVoca(bookId: 5004, vocaName: "figure", vocaMean: "숫자")
            gbbulManager.createVoca(bookId: 5004, vocaName: "activity", vocaMean: "활동")
            gbbulManager.createVoca(bookId: 5004, vocaName: "cause", vocaMean: "원인")
            gbbulManager.createVoca(bookId: 5004, vocaName: "worth", vocaMean: "가치")
            gbbulManager.createVoca(bookId: 5004, vocaName: "accident", vocaMean: "사고")
            gbbulManager.createVoca(bookId: 5004, vocaName: "adventure", vocaMean: "모험")
            
            gbbulManager.createVoca(bookId: 5005, vocaName: "view", vocaMean: "경치")
            gbbulManager.createVoca(bookId: 5005, vocaName: "superstition", vocaMean: "미신")
            gbbulManager.createVoca(bookId: 5005, vocaName: "habit", vocaMean: "습관")
            gbbulManager.createVoca(bookId: 5005, vocaName: "wealth", vocaMean: "재산")
            gbbulManager.createVoca(bookId: 5005, vocaName: "treasure", vocaMean: "보물")
            gbbulManager.createVoca(bookId: 5005, vocaName: "universe", vocaMean: "우주")
            gbbulManager.createVoca(bookId: 5005, vocaName: "adult", vocaMean: "성인")
            gbbulManager.createVoca(bookId: 5005, vocaName: "feast", vocaMean: "향연")
            gbbulManager.createVoca(bookId: 5005, vocaName: "resources", vocaMean: "자원")
            gbbulManager.createVoca(bookId: 5005, vocaName: "ruin", vocaMean: "파멸")
            
            gbbulManager.createVoca(bookId: 5006, vocaName: "A piece of cake", vocaMean: "식은 죽 먹기지")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Absolutely", vocaMean: "당근 빠따!")
            gbbulManager.createVoca(bookId: 5006, vocaName: "After you", vocaMean: "먼저 가세요.")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Amazing", vocaMean: "대단하네요")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Any good ideas?", vocaMean: "어떤 좋은 생각이라도?")
            
            gbbulManager.createVoca(bookId: 5006, vocaName: "Better than nothing", vocaMean: "없는 것 보다는 낫지요")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Can I get a ride?", vocaMean: "나를 태워다 줄 수 있어요?")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Check it out", vocaMean: " 확인해 봐봐")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Come on", vocaMean: "설마 (혹은 에이~~)")
            gbbulManager.createVoca(bookId: 5006, vocaName: "Could be", vocaMean: "그럴 수도 있죠")
            
            gbbulManager.createVoca(bookId: 5007, vocaName: "Definitely", vocaMean: "당근 빳다죠")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Did you get it?", vocaMean: "알아 들었어요?")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Doing okay?", vocaMean: "잘 하고 있어요?")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don’t get too serious", vocaMean: "너무 심각하게 그러지 말아요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don't be shy", vocaMean: "부끄러워 하지 마세요")
            
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don't get upset", vocaMean: "너무 화내지 말아요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don't let me down", vocaMean: "나를 실망시키지 말아요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don't push me!", vocaMean: "너무 강요 하지 말아요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Don't worry about it", vocaMean: "걱정하지 말아요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Drive safely!", vocaMean: "안전운행 하세요~")
            
            gbbulManager.createVoca(bookId: 5007, vocaName: "Easy does it", vocaMean: "천천히 해요. 조심스럽게 하세요(혹은 진정해요. 성질내지 말고)")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Either will do", vocaMean: " 둘중에 어떤 것이든 되요")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Exactly", vocaMean: "바로 그거죠")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Excellent!", vocaMean: " 짱!")
            gbbulManager.createVoca(bookId: 5007, vocaName: "Excuse me", vocaMean: "실례합니다")
            
            gbbulManager.createVoca(bookId: 5008, vocaName: "view", vocaMean: "경치")
            gbbulManager.createVoca(bookId: 5008, vocaName: "superstition", vocaMean: "미신")
            gbbulManager.createVoca(bookId: 5008, vocaName: "min", vocaMean: "최소")
            gbbulManager.createVoca(bookId: 5008, vocaName: "max", vocaMean: "최대")
            gbbulManager.createVoca(bookId: 5008, vocaName: "head", vocaMean: "파일의 시작부분")
            gbbulManager.createVoca(bookId: 5008, vocaName: "tail", vocaMean: "파일의 끝부분")
            gbbulManager.createVoca(bookId: 5008, vocaName: "upperCase", vocaMean: "대문자")
            gbbulManager.createVoca(bookId: 5008, vocaName: "lowerCase", vocaMean: "소문자")
            gbbulManager.createVoca(bookId: 5008, vocaName: "wide", vocaMean: "넓은")
            gbbulManager.createVoca(bookId: 5008, vocaName: "narrow", vocaMean: "좁은")
            
            gbbulManager.createVoca(bookId: 5009, vocaName: "previous", vocaMean: "이전")
            gbbulManager.createVoca(bookId: 5009, vocaName: "next", vocaMean: "다음")
            gbbulManager.createVoca(bookId: 5009, vocaName: "forward", vocaMean: "앞으로")
            gbbulManager.createVoca(bookId: 5009, vocaName: "backward", vocaMean: "뒤로")
            gbbulManager.createVoca(bookId: 5009, vocaName: "foreground", vocaMean: "전경")
            gbbulManager.createVoca(bookId: 5009, vocaName: "background", vocaMean: "배경")
            gbbulManager.createVoca(bookId: 5009, vocaName: "push", vocaMean: "넣는다")
            gbbulManager.createVoca(bookId: 5009, vocaName: "pop", vocaMean: "꺼낸다")
            gbbulManager.createVoca(bookId: 5009, vocaName: "enqueue", vocaMean: "대기열에 추가")
            gbbulManager.createVoca(bookId: 5009, vocaName: "dequeue", vocaMean: "대기열에서 꺼낸다")
        }
    }
    
    
    func sceneWillResignActive(_ scene: UIScene) {
        let manager = GbbulManager()
        guard let vocas = manager.getVoca(by: Int64.random(in: 5001...5005)) else { return }
        
        let randomIndex = Int(arc4random_uniform(UInt32(vocas.count)))
        let randomVoca = vocas[randomIndex]
        
        guard let name = randomVoca.vocaName else { return }
        guard let mean = randomVoca.vocaMean else { return }
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "오늘의 단어 ☺️"
        notificationContent.body = "\(name) :  \(mean)"
        
        let timeInterval: TimeInterval = 2
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let identifier = "unique_identifier"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
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
        bookNavController.navigationBar.tintColor = Palette.gray.getColor()
        let myBookNavController = UINavigationController(rootViewController: myBookViewController)
        myBookNavController.navigationBar.tintColor = Palette.gray.getColor()
        let myPageNavController = UINavigationController(rootViewController: myPageViewController)
        myPageNavController.navigationBar.tintColor = Palette.gray.getColor()

        viewControllers = [bookNavController, myBookNavController, myPageNavController]
        tabBar.tintColor = .black
        
        self.modalPresentationStyle = .fullScreen
    }

}
