//
//  BookViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class BookViewController: UIViewController {
    // 테이블뷰
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 라벨 생성
        let bookViewTitleLabel = UILabel()
        bookViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookViewTitleLabel)
        
        //테이블뷰 설정
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 테두리 설정
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = Palette.purple.getColor().cgColor
        tableView.layer.cornerRadius = 10
        
        // 제약 조건 - 라벨 위에 테이블 뷰 추가
        bookViewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstMargin.safeAreaTopMargin.getMargin()).isActive = true
        
        // 테이블 뷰 제약 조건 설정
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: bookViewTitleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstMargin.safeAreaLeftMargin.getMargin()).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstMargin.safeAreaRightMargin.getMargin()).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ConstMargin.safeAreaBottomMargin.getMargin()).isActive = true
        // 제약 조건
        bookViewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstMargin.safeAreaTopMargin.getMargin()).isActive = true
        
        // 라벨 생성
        bookViewTitleLabel.setUpLabel(title: "단어장 추가하기", fontSize: .large)
        
    }
}

extension BookViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테이블 뷰의 셀 개수 반환
        return 5 // 원하는 개수로 변경하세요.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀 구성 및 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "테이블 뷰 셀" // 셀에 표시할 내용 설정
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = BookInformationViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
