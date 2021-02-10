//
//  SignupNameViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/05.
//

import Foundation
import UIKit


class SignupNameViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNextButton(_ sender: UIButton) {
        guard checkNameValidate() else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupEmailViewController") as? SignupEmailViewController else{
            return
        }
        let userData = DIR_User()
        userData.name = "유지은"
        vc.userData = userData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkNameValidate() -> Bool{
        //이름 유효체크
        //유효하지않으면 alert and return false
        return true
    }
}
