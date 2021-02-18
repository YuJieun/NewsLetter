//
//  UIViewExtension.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import Foundation
import UIKit

extension UIView {
    public class func fromNib<T>(className: String, as type: T.Type) -> T {
        if let path: String = Bundle.main.path(forResource: className, ofType: "nib") {
            if FileManager.default.fileExists(atPath: path) {
                let view: UIView = Bundle.main.loadNibNamed(className, owner: nil, options: nil)!.first as! UIView
                return view as! T
            }
        }
        fatalError("\(className) XIB File Not Exist")
    }
}
