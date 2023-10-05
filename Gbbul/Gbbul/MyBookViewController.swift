//
//  MyBookViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit
import CoreData

class MyBookViewController: BaseViewController {
    private var manager = GbbulManager()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.setUpLabel(title: "단어장 추가하기", fontSize: .large)
        return label
    }()
    
    private lazy var addBookButton = {
        let btn = UIButton()
        btn.setUpButton(title: "+")
        btn.addTarget(self, action: #selector(addBookButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var textholderlabel = {
        let label = UILabel()
        label.text = "단어장을 추가해주세요"
        label.font = UIFont.systemFont(ofSize: LabelFontSize.medium.rawValue)
        label.textColor = Palette.purple.getColor()
        return label
    }()
    
    private lazy var tableView = {
        let tv = UITableView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = Palette.purple.getColor().cgColor
        tv.layer.cornerRadius = 10
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTableView()
        tableView.reloadData()
    }
    
    
    // MARK: - Funtion
    
    func addSubView(){
        view.addSubview(titleLabel)
        view.addSubview(addBookButton)
        view.addSubview(textholderlabel)
        view.addSubview(tableView)
    }
    
    
    func makeConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        addBookButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaLeftMargin.getMargin())
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        
        textholderlabel.snp.makeConstraints { make in
            make.top.equalTo(addBookButton.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addBookButton.snp.bottom).offset(ConstMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaRightMargin.getMargin())
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-ConstMargin.safeAreaBottomMargin.getMargin())
        }
        
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        
        if manager.getMyBook()!.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    
    @objc func addBookButtonTapped(){
        let nextVC = MyBookViewController2()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}


// MARK: - UITableViewDelegate

extension MyBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedBook = manager.getMyBook()?[indexPath.row] {
            let vocaView = myVocaView()
            
            vocaView.selectedBookTitle = selectedBook.myBookName
            vocaView.selectedBookId = selectedBook.bookId
            
            self.navigationController?.pushViewController(vocaView, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let book = manager.getMyBook()?[indexPath.row] {
                manager.deleteWordsInBook(book)
                manager.deleteMyBook(book)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
}


// MARK: - UITableViewDataSource

extension MyBookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getMyBook()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text = manager.getMyBook()?[indexPath.row].myBookName
        cell.textLabel?.font = UIFont.systemFont(ofSize: LabelFontSize.smallMedium.rawValue)
        return cell
    }
    
    
}

