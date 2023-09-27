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
        titleLabel.setUpLabel(title: "닉네임 :", fontSize: .medium, isFontBold:  false, titleColor: .lightGray)
        return titleLabel
    }()
    private lazy var levelLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "레벨 : LV", fontSize: .medium,  isFontBold:  false, titleColor: .lightGray)
        return titleLabel
    }()
    private lazy var nextLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "다음레벨 LV", fontSize: .small, titleColor: .lightGray)
        return titleLabel
    }()
    private lazy var myVocaLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "단어 공유소", fontSize: .medium, titleColor: .lightGray)
        return titleLabel
    }()
    private lazy var myBookLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.setUpLabel(title: "내 단어장", fontSize: .medium, titleColor: .lightGray)
        return titleLabel
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.setUpView()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        for _ in 1...5 {
            let ratingView = UIView()
            ratingView.setUpView(borderColor : .purple, borderWidth: 1)
            stackView.addArrangedSubview(ratingView)
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
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
        loadCorrectRateData()
        loadUserData()
        loadTableView()
    }
    private func loadTableView(){
        bookTableView.reloadData()
        vocaTableView.reloadData()
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
    private func setRate(number: Int) {
        for (_, subview) in ratingView.subviews.enumerated() {
            if let stackView = subview as? UIStackView {
                for (starIndex, starImageView) in stackView.arrangedSubviews.enumerated() {
                    if starIndex < number {
                        starImageView.backgroundColor = Palette.boldPink.getColor()
                        
                    } else {
                        starImageView.backgroundColor = .white
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
        //let exp = currentUser.exp // Todo 레이팅 세팅.
        let exp = 3
        setRate(number: Int(exp))
        
    }
    private func loadCorrectRateData(){
        // Todo CoreData 기준으로 분류
        for correctRate in correctRates {
            let bookId = correctRate.bookId
            let bookName: String
            var rate: Double
            if bookId >= 5001 {
                if let voca = vocas.first(where: { $0.bookId == bookId }) {
                    bookName = voca.myBookName
                    rate = correctRate.rate
                    vocaData.append((bookId: bookId, bookName: bookName, rate: rate))
                }
            } else {
                if let book = myBooks.first(where: { $0.bookId == bookId }) {
                    bookName = book.myBookName
                    rate = correctRate.rate
                    bookData.append((bookId: bookId, bookName: bookName, rate: rate))
                }
            }
        }
        for data in bookData {
            print("bookData - > bookId: \(data.bookId), bookName: \(data.bookName), rate: \(data.rate)")
        }
        for data in vocaData {
            print("vocaData - > bookId: \(data.bookId), bookName: \(data.bookName), rate: \(data.rate)")
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
            configCellStyle(cell, bookName: book.bookName, bookId: book.bookId, rate: book.rate)
        } else {
            let voca = vocaData[indexPath.row]
            configCellStyle(cell, bookName: voca.bookName, bookId: voca.bookId, rate: voca.rate)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == bookTableView
        {
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completion) in
                print(bookData[indexPath.row].bookId) // Todo 삭제
                completion(true)
            }
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            swipeConfig.performsFirstActionWithFullSwipe = false
            return swipeConfig
            
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bookTableView
        {
            let vc = MyBookViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * LayoutMultiplier.extraSmall.getScale()
    }
    func configCellStyle(_ cell: MyPageCustomCell, bookName: String, bookId: Int, rate: Double) {
        cell.titleLabel.text = bookName
        cell.bookId = bookId
        cell.correctRateLabel.text = "정답률 \(String(rate))%"
        if rate == 100.0 {
            cell.correctRateLabel.textColor = Palette.lightBlue.getColor()
        } else if (rate >= 40.0 && rate < 100) {
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
    var bookId : Int = 0
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

//Dummy
struct correctRate{
    let bookId : Int
    let total : Int
    let correct : Int
    let incorrect : Int
    let rate : Double
}
struct book{
    let bookId : Int
    let myBookName : String
    let myCreateDate : String
    
}
struct voca{
    let bookId : Int
    let myBookName : String
    let myCreateDate : String
}
let myBooks: [book] = [
    book(bookId: 0, myBookName: "IT 용어사전", myCreateDate: Date().GetCurrentTime()),
    book(bookId: 1, myBookName: "영어 단어장", myCreateDate: Date().GetCurrentTime()),
    book(bookId: 2, myBookName: "포르투갈어 단어장", myCreateDate: Date().GetCurrentTime()),
    book(bookId: 3, myBookName: "스페인어 단어장", myCreateDate: Date().GetCurrentTime())
]

let vocas: [voca] = [
    voca(bookId: 5001, myBookName: "정보처리기사 용어", myCreateDate: Date().GetCurrentTime()),
    voca(bookId: 5002, myBookName: "빅데이터 용어", myCreateDate: Date().GetCurrentTime()),
    voca(bookId: 5003, myBookName: "VR 용어", myCreateDate: Date().GetCurrentTime()),
    voca(bookId: 5004, myBookName: "국어사전", myCreateDate: Date().GetCurrentTime()),
    voca(bookId: 5005, myBookName: "영어사전", myCreateDate: Date().GetCurrentTime())
]


var correctRates : [correctRate] = [
    correctRate(bookId: myBooks[0].bookId, total: 25, correct: 10, incorrect:20, rate: 45),
    correctRate(bookId: myBooks[1].bookId, total: 25, correct: 10, incorrect:20, rate: 65),
    correctRate(bookId: myBooks[2].bookId, total: 25, correct: 10, incorrect:20, rate: 78),
    correctRate(bookId: myBooks[3].bookId, total: 25, correct: 10, incorrect:20, rate: 100),
    correctRate(bookId: vocas[0].bookId, total: 25, correct: 10, incorrect:20, rate: 14),
    correctRate(bookId: vocas[1].bookId, total: 25, correct: 10, incorrect:20, rate: 100),
    correctRate(bookId: vocas[2].bookId, total: 25, correct: 10, incorrect:20, rate: 51),
    correctRate(bookId: vocas[3].bookId, total: 25, correct: 10, incorrect:20, rate: 66),
    correctRate(bookId: vocas[4].bookId, total: 25, correct: 10, incorrect:20, rate: 77)
]

var bookData: [(bookId: Int, bookName: String, rate: Double)] = []
var vocaData: [(bookId: Int, bookName: String, rate: Double)] = []
