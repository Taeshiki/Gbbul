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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private let gbbulManager = GbbulManager()
    
    private var bookDataFromCoreData: [Book] = []
    
    func loadBookData() {
        if let books = gbbulManager.getBook() {
            bookDataFromCoreData = books
            tableView.reloadData()
        }
    }
    
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
        bookViewTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ConstMargin.safeAreaTopMargin.getMargin()).isActive = true
        bookViewTitleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: ConstMargin.safeAreaLeftMargin.getMargin()).isActive = true
        
        // 라벨 생성
        bookViewTitleLabel.setUpLabel(title: "단어 공유소", fontSize: .large)
        
        loadBookData()
    }
}

extension BookViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테이블 뷰의 셀 개수 반환
        return bookDataFromCoreData.count // 원하는 개수로 변경하세요.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀 구성 및 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let bookData = bookDataFromCoreData[indexPath.row]
        
        cell.textLabel?.text = bookData.bookName // 셀에 표시할 내용 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: LabelFontSize.smallMedium.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 셀의 Book 데이터 가져오기
        let selectedBook = bookDataFromCoreData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 책의 bookId 가져오기
        let selectedBookId = selectedBook.bookId
        if let selectedBookName = selectedBook.bookName {
            let bookInfoViewController = BookInformationViewController()
            
            // 전환할 화면에 선택한 bookId 및 bookName 전달
            bookInfoViewController.bookId = selectedBookId
            bookInfoViewController.bookName = selectedBookName
            
            // 화면 전환
            navigationController?.pushViewController(bookInfoViewController, animated: true)
        }
    }
}
