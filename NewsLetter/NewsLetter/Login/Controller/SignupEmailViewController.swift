//
//  SignupEmailViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import UIKit

class SignupEmailViewController: UIViewController {

    
    var userData: DIR_User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let data = self.userData else { return }
//        self.nameLabel.text = data.name
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard let data = userData else { return }
        guard checkEmailValidate() else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupPasswordViewController") as? SignupPasswordViewController else{
            return
        }
        data.email = "jieun@gmail.com"
        vc.userData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkEmailValidate() -> Bool {
        //이메일 유효체크
        //유효하지 않으면 alert and return false
        return true
    }
}
