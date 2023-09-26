//
//  BookViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class BookViewController: UIViewController {
    // 테이블뷰

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 라벨 생성
        let bookViewTitleLabel = UILabel()
        bookViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookViewTitleLabel)
        
        // 제약 조건
        bookViewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constMargin.safeAreaTopMargin.getMargin()).isActive = true
        
        // 라벨 생성
        bookViewTitleLabel.setUpLabel(title: "단어장 추가하기", fontSize: .large)
        
    }
}
