//
//  UIViewExtension.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import Foundation
import UIKit

extension UIView {
    public class func getXib<T>(className: String, as type: T.Type) -> T {
        if let path: String = Bundle.main.path(forResource: className, ofType: "nib") {
            if FileManager.default.fileExists(atPath: path) {
                let view: UIView = Bundle.main.loadNibNamed(className, owner: nil, options: nil)!.first as! UIView
                return view as! T
            }
        }
        fatalError("\(className) XIB File Not Exist")
    }

    public class func getXibSize() -> CGSize {
        return getXib(cache: true).frame.size
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    ///   variable to get the height of the view.
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    public var width: CGFloat {
        get {
            return self.w
        }
        set {
            self.w = newValue
        }
    }

    public var height: CGFloat {
        get {
            return self.h
        }
        set {
            self.h = newValue
        }
    }

}
