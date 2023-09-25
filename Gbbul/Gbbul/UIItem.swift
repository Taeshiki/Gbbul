//
//  UIItem.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

extension UIButton {
    func setUpButton(title: String) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 199/255, alpha: 1)
        setTitle(title, for: .normal)
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel?.font = boldFont
        setTitleColor(UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1), for: .normal)
    }
}

extension UILabel {
    func setUpLabel(title: String, fontSize: LabelFontSize) {
        self.text = title
        self.font = UIFont.boldSystemFont(ofSize: fontSize.rawValue)
        let titleColor = UIColor(red: 135/255, green: 133/255, blue: 162/255, alpha: 1)
        self.textColor = titleColor
    }
}

enum LabelFontSize: CGFloat {
    case small = 10
    case medium = 18
    case large = 25
}
