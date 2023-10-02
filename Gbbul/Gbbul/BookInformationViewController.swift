//
//  BookViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class BookInformationViewController: UIViewController {
    // 테이블뷰
    
    var bookId: Int64 = 0
    var bookName: String = ""
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let gbbulManager = GbbulManager()
    
    var vocaDatas: [Voca] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 라벨 생성
        let bookViewTitleLabel = UILabel()
        bookViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookViewTitleLabel)
        // 버튼 생성
        let studyButton = UIButton()
        studyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(studyButton)
        
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
        tableView.bottomAnchor.constraint(equalTo: studyButton.topAnchor, constant: -20).isActive = true
        // 제약 조건
        bookViewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstMargin.safeAreaTopMargin.getMargin()).isActive = true
        
        // 버튼 설정
        studyButton.setUpButton(title: "학습하기")
        
        // 버튼 제약조건
        studyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -20).isActive = true
        studyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        studyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        studyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        studyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ConstMargin.safeAreaBottomMargin.getMargin()).isActive = true
        
        
        // 라벨 생성
        bookViewTitleLabel.setUpLabel(title: "\(bookName)", fontSize: .large)
        
        if let vocas = gbbulManager.getVoca(by: bookId) {
            vocaDatas = vocas
            tableView.reloadData()
        }

    }
}

extension BookInformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테이블 뷰의 셀 개수 반환
        return vocaDatas.count // 원하는 개수로 변경하세요.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀 구성 및 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let vocaData = vocaDatas[indexPath.row]
        cell.textLabel?.text = "\(vocaData.vocaName) : \(vocaData.vocaMean)"// 셀에 표시할 내용 설정
        return cell
    }
    
}
