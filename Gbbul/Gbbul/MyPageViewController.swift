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
        let nicknameLabel = UILabel()
        nicknameLabel.setUpLabel(title: "닉네임 :", fontSize: .medium, isFontBold:  false, titleColor: .lightGray)
        return nicknameLabel
    }()
    private lazy var levelLabel : UILabel = {
        let levelLabel = UILabel()
        levelLabel.setUpLabel(title: "레벨 : LV", fontSize: .medium,  isFontBold:  false, titleColor: .lightGray)
        return levelLabel
    }()
    private lazy var nextLabel : UILabel = {
        let nextLabel = UILabel()
        nextLabel.setUpLabel(title: "다음레벨 LV", fontSize: .small, titleColor: .lightGray)
        return nextLabel
    }()
    private lazy var myVocaLabel : UILabel = {
        let myVocaLabel = UILabel()
        myVocaLabel.setUpLabel(title: "단어 공유소", fontSize: .medium, titleColor: .lightGray)
        return myVocaLabel
    }()
    private lazy var myBookLabel : UILabel = {
        let myBookLabel = UILabel()
        myBookLabel.setUpLabel(title: "내 단어장", fontSize: .medium, titleColor: .lightGray)
        return myBookLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.setUpView()
        
        let ratingStackView = UIStackView()
        ratingStackView.axis = .horizontal
        ratingStackView.alignment = .fill
        ratingStackView.distribution = .fillEqually
        for _ in 1...5 {
            let ratingView = UIView()
            ratingView.setUpView(borderColor : .purple, borderWidth: 1)
            ratingStackView.addArrangedSubview(ratingView)
        }
        view.addSubview(ratingStackView)
        ratingStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return view
    }()
    private lazy var bookTableView : UITableView = {
        let bookTableView = UITableView()
        bookTableView.setUpTableView(borderColor : .lightBlue)
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(MyPageCustomCell.self, forCellReuseIdentifier: "MyPageCustomCell")
        return bookTableView
    }()
    private lazy var vocaTableView : UITableView = {
        let vocaTableView = UITableView()
        vocaTableView.setUpTableView(borderColor : .boldPink)
        vocaTableView.delegate = self
        vocaTableView.dataSource = self
        vocaTableView.register(MyPageCustomCell.self, forCellReuseIdentifier: "MyPageCustomCell")
        return vocaTableView
    }()
    
    private var manager : GbbulManager!
    private var bookData: [(bookId: Int, bookName: String, rate: Double)] = []
    private var vocaData: [(bookId: Int, bookName: String, rate: Double)] = []
    private var rateCount : Int = 0
    private var level = 0
    private var exp = 0
    private var userName = ""
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
        super.viewWillAppear(animated)
        Task{
            await loadMyPageData()
        }
    }
    private func configUI(){
        [titleLabel,nicknameLabel,levelLabel,ratingView,nextLabel,myVocaLabel,nextLabel,myBookLabel,bookTableView,vocaTableView].forEach(view.addSubview)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstMargin.safeAreaTopMargin.getMargin())
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstMargin.safeAreaLeftMargin.getMargin())
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        nextLabel.snp.makeConstraints{
            $0.top.equalTo(levelLabel.snp.bottom).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-ConstMargin.safeAreaRightMargin.getMargin())
        }
        ratingView.snp.makeConstraints {
            $0.top.equalTo(nextLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(nextLabel.snp.trailing)
            $0.height.equalTo(view.snp.height).multipliedBy(LayoutMultiplier.superExtraSmall.getScale())
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
            $0.height.equalToSuperview().multipliedBy(LayoutMultiplier.quarter.getScale())
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-ConstMargin.safeAreaBottomMargin.getMargin())
        }
    }
}
extension MyPageViewController{
    private func loadMyPageData() async {
        await clearMyPageData()
        await loadCorrectRateData()
        await loadUserData()
        updateUI()
    }
    private func clearMyPageData() async {
        bookData.removeAll()
        vocaData.removeAll()
        rateCount = 0
    }
    private func loadUserData() async  {
        guard let userData = manager.getUser(), let currentUser = userData.first else {
            showAlert(title: "에러", message: "유저정보가 존재하지 않습니다.")
            return
        }
        level = rateCount / 5
        exp = rateCount % 5
        userName = currentUser.name!
        await manager.updateUser(exp: Int64(exp), level: Int64(level), name: userName)
    }
    private func loadCorrectRateData() async {
        let bookList = await manager.getMyPageData()
        for (bookId, bookName, rateValue) in bookList {
            if rateValue == 100 {
                rateCount += 1
            }
            if bookId >= 5001 {
                vocaData.append((bookId: bookId, bookName: bookName, rate: rateValue))
            } else {
                bookData.append((bookId: bookId, bookName: bookName, rate: rateValue))
            }
        }
    }
    private func setRate(number: Int) {
        for (_, subview) in ratingView.subviews.enumerated() {
            if let stackView = subview as? UIStackView {
                for (starIndex, starImageView) in stackView.arrangedSubviews.enumerated() {
                    starImageView.backgroundColor = (starIndex < number) ? Palette.boldPink.getColor() : .white
                }
            }
        }
    }
    private func updateUI(){
        Task {@MainActor in
            setRate(number: rateCount % 5)
            
            nicknameLabel.text = "닉네임 : " + userName
            levelLabel.text = "레벨 : Lv" + String(level)
            nextLabel.text = "다음레벨 LV" + String(level + 1)
            
            bookTableView.reloadData()
            vocaTableView.reloadData()
        }
    }
}
extension MyPageViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bookTableView{
            return bookData.count
        }else{
            return vocaData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCustomCell") as? MyPageCustomCell else {
            return UITableViewCell()
        }
        if tableView == bookTableView {
            let book = bookData[indexPath.row]
            configCellStyle(cell, bookName: book.bookName, bookId: book.bookId, rate: Int(book.rate))
        } else {
            let voca = vocaData[indexPath.row]
            configCellStyle(cell, bookName: voca.bookName, bookId: voca.bookId, rate: Int(voca.rate))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bookTableView
        {
            let vc = StudyViewController()
            vc.bookId = Int64(bookData[indexPath.row].bookId)
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = StudyViewController()
            vc.bookId = Int64(vocaData[indexPath.row].bookId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * LayoutMultiplier.extraSmall.getScale()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == bookTableView {
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
                guard let self = self else { return }
                Task { [weak self] in //가독성때문에 weak self로 캡쳐.
                    guard let self = self else{return}
                    do {
                        try await deleteBookItemAndReloadData(at: indexPath)
                        completion(true)
                    } catch {
                        print("삭제 중 에러 발생: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            }
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            swipeConfig.performsFirstActionWithFullSwipe = false
            return swipeConfig
        } else {
            return nil
        }
    }
    
    private func deleteBookItemAndReloadData(at indexPath: IndexPath) async throws{
        await manager.deleteMyBookItem(bookId: Int64(bookData[indexPath.row].bookId))
        await loadMyPageData()
    }
    private func configCellStyle(_ cell: MyPageCustomCell, bookName: String, bookId: Int, rate: Int) {
        cell.titleLabel.text = bookName
        cell.correctRateLabel.text = "정답률 \(String(rate))%"
        if rate == 100 {
            cell.correctRateLabel.textColor = Palette.lightBlue.getColor()
        } else if (rate >= 40 && rate < 100) {
            cell.correctRateLabel.textColor = Palette.lightGray.getColor()
        } else {
            cell.correctRateLabel.textColor = Palette.red.getColor()
        }
    }
}

class MyPageCustomCell : UITableViewCell
{
    var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "", fontSize: .medium, isFontBold:  false, titleColor: .lightGray)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    var correctRateLabel : UILabel = {
        let correctRateLabel = UILabel()
        correctRateLabel.setUpLabel(title: "", fontSize: .medium, isFontBold:  false, titleColor: .lightGray)
        correctRateLabel.textAlignment = .right
        return correctRateLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCellStyle()
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("MyPageCustomCell coder Error")
    }
    private func configCellStyle(){
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = .none
    }
    
    private func configUI() {
        [titleLabel, correctRateLabel].forEach(contentView.addSubview)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.width.equalTo(contentView.snp.width).multipliedBy(LayoutMultiplier.medium.getScale())
        }
        correctRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
}
