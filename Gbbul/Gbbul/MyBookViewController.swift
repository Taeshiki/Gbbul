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
        return tv
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        makeConstraints()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
        }
        
        addBookButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-constMargin.safeAreaLeftMargin.getMargin())
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        
        textholderlabel.snp.makeConstraints { make in
            make.top.equalTo(addBookButton.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addBookButton.snp.bottom).offset(constMargin.safeAreaTopMargin.getMargin())
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-constMargin.safeAreaRightMargin.getMargin())
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-constMargin.safeAreaBottomMargin.getMargin())
        }
        
        
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        
        if manager.getBook()!.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    
    
    @objc func addBookButtonTapped(){
        // 네비게이션 컨트롤러 안쓰는지?
        let nextVC = MyBookViewController2()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    
}


// MARK: - UITableViewDelegate

extension MyBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


// MARK: - UITableViewDataSource

extension MyBookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getBook()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text = manager.getBook()?[indexPath.row].myBookName
        cell.textLabel?.font = UIFont.systemFont(ofSize: LabelFontSize.medium.rawValue)
        return cell
    }
    
    
}
