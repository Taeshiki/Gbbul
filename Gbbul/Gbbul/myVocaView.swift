//
//  myVocaView.swift
//  Gbbul
//
//  Created by Kyle on 2023/09/26.
//

import UIKit
import SnapKit

class myVocaView: BaseViewController {

    let vocabularyData: [(word: String, meaning: String)] = [
        ("Apple", "사과"),
        ("Banana", "바나나"),
    ]
    
    let titleLabel: UILabel = {
        $0.setUpLabel(title: "비 전공자를 위한 IT 단어장", fontSize: .large)
        return $0
    }(UILabel())
    
    let hiddenLabel: UILabel = {
        $0.setUpLabel(title: "단어를 추가 해주세요.", fontSize: .medium)
        return $0
    }(UILabel())
    
    let learnButton: UIButton = {
        $0.setUpButton(title: "학습하기")
        return $0
    }(UIButton())
    
    let floatingButton: UIButton = {
        $0.setTitle("+", for: .normal)
        $0.backgroundColor = Palette.boldPink.getColor()
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .custom))
    
    let vocaTableView: UITableView = {
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setconstraints()
        setTableView()
    }
    
    func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(floatingButton)
        view.addSubview(vocaTableView)
        view.addSubview(hiddenLabel)
        view.addSubview(learnButton)
    }
    
    func setconstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constMargin.safeAreaTopMargin.getMargin())
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(constMargin.safeAreaLeftMargin.getMargin())
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(constMargin.safeAreaRightMargin.getMargin())
        }
        
        floatingButton.snp.makeConstraints {
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.width.height.equalTo(60)
        }
        
        vocaTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().offset(20)
            $0.bottom.equalTo(learnButton.snp.top).offset(-20)
        }
        
        hiddenLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().offset(20)
        }
        
        learnButton.snp.makeConstraints {
            $0.bottom.equalTo(floatingButton.snp.top).offset(-20)
            $0.width.equalTo(180)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setTableView() {
        vocaTableView.delegate = self
        vocaTableView.dataSource = self
        
        if vocabularyData.isEmpty {
            hiddenLabel.isHidden = false
            vocaTableView.isHidden = true
        } else {
            hiddenLabel.isHidden = true
            vocaTableView.isHidden = false
        }
    }
    
    func setButtonTarget() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        let vocaView2VC = myVocaView2()
        
        present(vocaView2VC, animated: true)
    }
    
    @objc func learnButtonTapped() {
        
    }
}

extension myVocaView: UITableViewDelegate {
    
}

extension myVocaView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabularyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let wordAndMeaning = vocabularyData[indexPath.row]
        cell.textLabel?.text = wordAndMeaning.word
        cell.detailTextLabel?.text = wordAndMeaning.meaning
        
        return cell
    }
}

//import SwiftUI
//
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreview() -> some View {
//        Preview(viewController: self)
//    }
//}
//#endif
//
//struct VCPreView:PreviewProvider {
//    static var previews: some View {
//        myVocaView().toPreview()
//    }
//}
