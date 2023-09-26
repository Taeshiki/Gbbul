//
//  MyPageViewController.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

class MyPageViewController: BaseViewController {
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "마이페이지", fontSize: .large)
        return titleLabel
    }()
    private lazy var nicknameLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "닉네임 :", fontSize: .medium)
        return titleLabel
    }()
    private lazy var levelLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "레벨 : LV", fontSize: .medium)
        return titleLabel
    }()
    private lazy var nextLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "다음레벨 LV", fontSize: .small)
        return titleLabel
    }()
    private lazy var myVocaLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "단어 공유소", fontSize: .medium)
        return titleLabel
    }()
    private lazy var myBookLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "내 단어장", fontSize: .medium)
        return titleLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = Palette.boldPink.getColor()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        for _ in 1...5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star")
            stackView.addArrangedSubview(starImageView)
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return view
    }()
    private lazy var bookTableView : UITableView = {
        let bookTableView = UITableView()
        bookTableView.setUpTableView()
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(MyPageCustomCell.self, forCellReuseIdentifier: "MyPageCustomCell")
        return bookTableView
    }()
    private lazy var vocaTableView : UITableView = {
        let vocaTableView = UITableView()
        vocaTableView.setUpTableView()
        vocaTableView.delegate = self
        vocaTableView.dataSource = self
        vocaTableView.register(MyPageCustomCell.self, forCellReuseIdentifier: "MyPageCustomCell")
        return vocaTableView
    }()
    
    private var manager : GbbulManager!
    init(manager : GbbulManager)
    {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.manager = GbbulManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUserData()
    }
    private func configUI(){
        [titleLabel,nicknameLabel,levelLabel,ratingView,nextLabel,myVocaLabel,nextLabel,myBookLabel,bookTableView,vocaTableView].forEach(view.addSubview)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constMargin.safeAreaTopMargin.getMargin())
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(constMargin.safeAreaLeftMargin.getMargin())
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        nextLabel.snp.makeConstraints{
            $0.top.equalTo(levelLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-constMargin.safeAreaRightMargin.getMargin())
        }
        ratingView.snp.makeConstraints {
            $0.top.equalTo(nextLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(nextLabel.snp.trailing)
            $0.height.equalTo(view.snp.height).multipliedBy(LayoutMultiplier.extraSmall.getScale())
        }
        myVocaLabel.snp.makeConstraints{
            $0.top.equalTo(ratingView.snp.bottom).offset(10)
            $0.leading.equalTo(ratingView.snp.leading)
        }
        vocaTableView.snp.makeConstraints{
            $0.top.equalTo(myVocaLabel.snp.bottom).offset(10)
            $0.leading.equalTo(ratingView.snp.leading)
            $0.trailing.equalTo(ratingView.snp.trailing)
            $0.height.equalToSuperview().multipliedBy(LayoutMultiplier.quarter.getScale())
        }
        myBookLabel.snp.makeConstraints{
            $0.top.equalTo(vocaTableView.snp.bottom).offset(10)
            $0.leading.equalTo(vocaTableView.snp.leading)
        }
        bookTableView.snp.makeConstraints {
            $0.top.equalTo(myBookLabel.snp.bottom).offset(10)
            $0.leading.equalTo(ratingView.snp.leading)
            $0.trailing.equalTo(ratingView.snp.trailing)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalToSuperview().multipliedBy(LayoutMultiplier.quarter.getScale())
        }
    }
}
extension MyPageViewController{
    private func setRate(number: Int) {
        for (_, subview) in ratingView.subviews.enumerated() {
            if let stackView = subview as? UIStackView {
                for (starIndex, starImageView) in stackView.arrangedSubviews.enumerated() {
                    if let starImageView = starImageView as? UIImageView {
                        if starIndex < number {
                            starImageView.image = UIImage(systemName: "star.fill")
                        } else {
                            starImageView.image = UIImage(systemName: "star")
                        }
                    }
                }
            }
        }
    }
    private func loadUserData() {
        guard let userData = manager.getUser(), let currentUser = userData.first else {
            showAlert(title: "에러", message: "유저정보가 존재하지 않습니다.")
            return
        }
        if let userName = currentUser.name {
            nicknameLabel.text = "닉네임 : " + userName
        }
        levelLabel.text = "레벨 : Lv" + String(currentUser.level)
        nextLabel.text = "다음레벨 LV" + String(currentUser.level+1)
        let exp = currentUser.exp
        setRate(number: Int(exp))
    }
}
extension MyPageViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bookTableView{
            return 5
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bookTableView{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCustomCell") as? MyPageCustomCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = "book테이블뷰adsjksadjkasdljkadsjkladsjkl임"
            cell.correctRateLabel.text = "정답률 5%"
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCustomCell") as? MyPageCustomCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = "ㅁㄴㄹㅁㄴㄹㅁㄴ뤄ㅏㅣㅁㄴ러ㅏㅣㅜㅁㄴ"
            cell.correctRateLabel.text = "정답률 100%"
            return cell
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == bookTableView
        {
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completion) in
                completion(true)
            }
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            swipeConfig.performsFirstActionWithFullSwipe = false
            return swipeConfig
            
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * LayoutMultiplier.extraSmall.getScale()
    }
}

class MyPageCustomCell : UITableViewCell
{
    var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "", fontSize: .medium)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        return titleLabel
    }()
    var correctRateLabel : UILabel = {
        let correctRateLabel = UILabel()
        correctRateLabel.setUpLabel(title: "", fontSize: .medium)
        correctRateLabel.textAlignment = .right
        correctRateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        correctRateLabel.setContentHuggingPriority(.required, for: .horizontal)
        return correctRateLabel
    }()
    var bookId : Int = 0
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("MyPageCustomCell coder Error")
    }
    func configUI() {
        [titleLabel, correctRateLabel].forEach(contentView.addSubview)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.width.equalTo(contentView.snp.width).multipliedBy(LayoutMultiplier.medium.getScale())
        }
        correctRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
}
