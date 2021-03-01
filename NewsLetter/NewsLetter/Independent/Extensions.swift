//
//  Independent.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import Foundation
import UIKit

public typealias CellClosure = (_ type: String, _ data: Any?) -> Void

extension UIAlertController {
    public func show() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        }
    }
}

extension UICollectionView {
    public func dequeueReusableCell<T: UICollectionViewCell>(_ Class: T.Type, _ className: String, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T //요 as가 관건임
        return cell
    }
    
    public func registerNibCell(_ ClassName: String, Classs: UICollectionViewCell.Type) {
        register(UINib(nibName: ClassName, bundle: nil), forCellWithReuseIdentifier: ClassName)
    }
    
}


extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }

    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}


extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
