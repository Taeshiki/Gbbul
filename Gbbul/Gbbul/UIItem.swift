//
//  UIItem.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import UIKit

extension UIButton {
    func setUpButton(title: String, titleSize : CGFloat = 20.0 ,titleColor : Palette = .white,backgroundColor: Palette = .boldPink) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor.getColor()
        setTitle(title, for: .normal)
        let boldFont = UIFont.boldSystemFont(ofSize: titleSize)
        self.titleLabel?.font = boldFont
        setTitleColor(titleColor.getColor(), for: .normal)
    }
    
    func resizeImageButton(image: UIImage?, width: Int, height: Int, color: UIColor) -> UIImage? {
        guard let image = image else { return nil }
        let newSize = CGSize(width: width, height: height)
        let coloredImage = image.withTintColor(color)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        coloredImage.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UILabel {
    func setUpLabel(title: String, fontSize: LabelFontSize, isFontBold: Bool = true, titleColor: Palette = .purple) {
        self.text = title
        self.font = isFontBold ? UIFont.boldSystemFont(ofSize: fontSize.rawValue) : UIFont.systemFont(ofSize: fontSize.rawValue)
        let titleColor = titleColor.getColor()
        self.textColor = titleColor
    }
}
extension UITextField{
    func setUpTextField(borderColor : Palette = .boldPink, borderWidth : CGFloat = 1.0){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.getColor().cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
}
extension UITableView{
    func setUpTableView(borderColor : Palette = .boldPink, borderWidth : CGFloat = 1.0){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.getColor().cgColor
    }
}
extension UIView{
    func setUpView(backgroundColor : Palette = .white ,borderColor : Palette = .white, borderWidth : CGFloat = 0 ){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.backgroundColor = backgroundColor.getColor().cgColor
        self.layer.borderColor = borderColor.getColor().cgColor
        self.layer.borderWidth = borderWidth
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
    
    func showAlertTwoButton(title: String,
                            message: String?,
                            button1Title: String,
                            button2Title: String,
                            completion1: (() -> Void)? = nil,
                            completion2: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action1 = UIAlertAction(title: button1Title, style: .default) { _ in
            completion1?()
        }

        let action2 = UIAlertAction(title: button2Title, style: .default) { _ in
            completion2?()
        }

        alertController.addAction(action1)
        alertController.addAction(action2)

        present(alertController, animated: true, completion: nil)
    }
}
extension Date{
    func GetCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
enum Palette {
    case white
    case boldPink
    case pink
    case purple
    case red
    case lightRed
    case lightBlue
    case lightGreen
    case lightYellow
    case lightBlack //큰타이틀용?
    case lightGray //소제목용?
    case gray // 텍스트용?
    case black
    
    func getColor() -> UIColor {
        switch self {
        case .lightYellow:
            return UIColor(red: 255/255, green: 255/255, blue: 204/255, alpha: 1)
        case .lightGreen:
            return UIColor(red: 102/255, green: 255/255, blue: 102/255, alpha: 1)
        case .red:
            return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        case .boldPink:
            return UIColor(red: 255/255, green: 199/255, blue: 199/255, alpha: 1)
        case .pink:
            return UIColor(red: 255/255, green: 226/255, blue: 226/255, alpha: 1)
        case .white:
            return UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        case .purple:
            return UIColor(red: 135/255, green: 133/255, blue: 162/255, alpha: 1)
        case .lightBlack:
            return UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        case .lightGray:
            return UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        case .gray:
            return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        case .lightBlue:
            return UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        case .lightRed:
            return UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        case .black:
            return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
    }
}
enum LabelFontSize: CGFloat {
    case small = 10
    case medium = 18
    case large = 25
}
enum ConstMargin {
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
