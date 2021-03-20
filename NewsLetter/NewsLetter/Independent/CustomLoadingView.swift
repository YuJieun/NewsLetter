//
//  CustomLoadingView.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/20.
//

import Foundation
import UIKit

class CustomLoadingView {
    private static let sharedInstance = CustomLoadingView()
        
    private var backgroundView: UIView?
    private var popupView: UIImageView?
        
    class func show() {
        let backgroundView = UIView()
        
        let popupView = UIImageView()
        popupView.contentMode = .center
        popupView.animationImages = CustomLoadingView.getAnimationImageArray()
        popupView.animationRepeatCount = 0
        
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first {
                window.addSubview(backgroundView)
                window.addSubview(popupView)
                
                backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
                backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            
                popupView.frame = CGRect(x: 0, y: 0,width: window.frame.maxX, height: window.frame.maxY)
                popupView.startAnimating()
                
                sharedInstance.backgroundView?.removeFromSuperview()
                sharedInstance.popupView?.removeFromSuperview()
                sharedInstance.backgroundView = backgroundView
                sharedInstance.popupView = popupView
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                window.addSubview(backgroundView)
                window.addSubview(popupView)
                
                backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
                backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
                
                popupView.frame = CGRect(x: 0, y: 0,width: window.frame.maxX, height: window.frame.maxY)
                popupView.startAnimating()
                
                sharedInstance.backgroundView?.removeFromSuperview()
                sharedInstance.popupView?.removeFromSuperview()
                sharedInstance.backgroundView = backgroundView
                sharedInstance.popupView = popupView
            }
        }
    }
    
    class func hide() {
        if let popupView = sharedInstance.popupView,
        let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
        }
    }
    
    public class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "pickyLetterLogo")!)
        return animationArray
    }

}
