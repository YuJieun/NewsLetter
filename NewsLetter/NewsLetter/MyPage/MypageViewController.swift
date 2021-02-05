//
//  MypageViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import UIKit

class MypageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("마이페이지")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSettingButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Mypage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
