//
//  CommonNavigationController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/28.
//

import Foundation
import UIKit

class CommonNavigationController: UIViewController {
    
    override func viewDidLoad() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x333333),
         NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 16)!]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "14BackPickygray"),
            style: .plain,
            target: self,
            action: #selector(self.back(sender:))
        )
        
        self.navigationController?.navigationBar.clipsToBounds = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}
