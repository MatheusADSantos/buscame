//
//  SettingPropertys.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func hexaToColor (hex:String) -> UIColor {
        var hexString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexString.hasPrefix("#")) {
            hexString.remove(at: hexString.startIndex)
        }
        
        if ((hexString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}

//extension CGColor {
//    class func colorWithHex(hex: Int) -> CGColorConversionInfo {
//        return UIColor(hex: hex).CGColor
//    }
//    
//}




extension UILabel {
    func setBasicLabel(text:String? = nil, textColor:UIColor? = .black, font:UIFont?, backgroundColor:UIColor? = .white, textAlignment:NSTextAlignment? = .center) {
        
        if let text = text {
            let localizedText = NSLocalizedString(text, comment: "")
            self.text = localizedText
        }
        if let textColor = textColor{
            self.textColor = textColor
        }
        if let font = font{
            self.font = font
        } else {
            self.font = UIFont.systemFont(ofSize: 15)
        }
        if let backgroundColor = backgroundColor{
            self.backgroundColor = backgroundColor
        }
        if let textAlignment = textAlignment{
            self.textAlignment = textAlignment
        }
        self.sizeToFit()
    }
}





extension UIButton {
    
    
    func setBasicButton(title:String?, font:UIFont?, cornerRadius:CGFloat? = 0) -> Void {
        if let title = title {
            let localizedTitle = NSLocalizedString(title, comment: "")
            setTitle(localizedTitle, for: .normal)
        }
        if let font = font {
            titleLabel?.font = font
        }
        if let cornerRadius = cornerRadius{
            layer.cornerRadius = cornerRadius
        }
    }
    
    func setButtonWithImage(named name:String, radius:CGFloat){
        layer.cornerRadius = radius
        setImage(UIImage(named: name), for: .normal)
    }

    
}


extension UIImageView {
    
    func setImage(name: String?,x: Int, y: Int, width: Int, height: Int) {
        if let name = name {
            self.image = UIImage(named: name)
        }
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
}


extension String {
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
//    func replaceName(nome : String) -> String {
//        var finalValueReplaced = nome
//        let arraySpecialCaracter : [String] = ["Á","É","Í","Ó","Ú","á","é","í","ó","ú","Â","Ê","Ô","â","ê","ô","À","à","Ü","ü","Ç","ç","Ñ","ñ","Ã","Õ","ã","õ"," "]
//        var arrayRight : [String] =           ["A","É","I","O","U","a","e","i","o","u","A","E","O","a","e","o","A","a","U","u","C","c","N","n","A","O","a","o","+"]
//        var count:Int = 0
//
//        arraySpecialCaracter.forEach { (char) in
//            finalValueReplaced = finalValueReplaced.replace(target: char, withString: arrayRight[count])
//            count+=1
//        }
//        return finalValueReplaced
//    }
    
    //Neste caso o self é o mesmo de quem chama o método, ou seja, quem for chamar o método se for uma string e por ser um método que extende de String então, self é a própria instancia do método ...
    mutating func replaceName() -> String {
        let arraySpecialCaracter : [String] = ["Á","É","Í","Ó","Ú","á","é","í","ó","ú","Â","Ê","Ô","â","ê","ô","À","à","Ü","ü","Ç","ç","Ñ","ñ","Ã","Õ","ã","õ"," "]
        var arrayRight : [String] =           ["A","É","I","O","U","a","e","i","o","u","A","E","O","a","e","o","A","a","U","u","C","c","N","n","A","O","a","o","%20"]
        var count:Int = 0
        arraySpecialCaracter.forEach { (char) in
            self = self.replace(target: char, withString: arrayRight[count])
            count+=1
        }
        return self
    }
    
    
}


extension UITextField {
    
    func recuo(_ parametro: Int) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(integerLiteral: parametro), height: self.frame.height))
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(integerLiteral: parametro), height: self.frame.height))
        self.leftView = leftView
        self.rightView = rightView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
}


extension UIViewController {
    
    func hideKeyboardTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
}



extension UIView {
    
    func setaShadow(view: UIView, alpha:CGFloat, offSetX: Float, offSetY: Float, shadowOpacity: Float, shadowRadius: CGFloat, bolean: Bool) -> UIView {
        view.alpha = alpha
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: Int(offSetX), height: Int(offSetY))
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        view.isUserInteractionEnabled = bolean
        
        return view
    }
    
}

