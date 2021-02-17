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
