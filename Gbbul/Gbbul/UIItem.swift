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
        let titleColor = Palette.purple.getColor()
        self.textColor = titleColor
    }
}

extension UITextField{
    func setUpTextField(){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Palette.boldPink.getColor().cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension Date {
    func GetCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: self)
        return dateString
    }
}

enum Palette {
    case boldPink
    case pink
    case white
    case purple
    
    func getColor() -> UIColor {
        switch self {
        case .boldPink:
            return UIColor(red: 255/255, green: 199/255, blue: 199/255, alpha: 1)
        case .pink:
            return UIColor(red: 255/255, green: 226/255, blue: 226/255, alpha: 1)
        case .white:
            return UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        case .purple:
            return UIColor(red: 135/255, green: 133/255, blue: 162/255, alpha: 1)
        }
    }
    
}

enum LabelFontSize: CGFloat {
    case small = 10
    case medium = 18
    case large = 25
}

enum constMargin {
    case safeAreaTopMargin
    case safeAreaLeftMargin
    case safeAreaRightMargin
    case safeAreaBottomMargin
    
    func getMargin() -> Double {
        switch self {
        case .safeAreaTopMargin:
            return 20
        case .safeAreaLeftMargin:
            return 20
        case .safeAreaRightMargin:
            return 20
        case .safeAreaBottomMargin:
            return 20
        }
    }
}

class BaseViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
