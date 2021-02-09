//
//  Independent.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import Foundation
import UIKit

extension String {
    public func toDictionary() -> [String: Any]? {
        let convString = replacingOccurrences(of: "\r\n", with: "\\n")
        if let data = convString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch {
                print("\(self) --> \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    public var isValid: Bool {
        if self.isEmpty || self.count == 0 || self.trim().count == 0 || self == "(null)" || self == "null" || self == "nil" {
            return false
        }

        return true
    }
    
    public func trim() -> String {
        let str: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return str
    }
}

extension UIAlertController {
    public func show() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        }
    }
    
    
}
