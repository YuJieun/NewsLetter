//
//  CommonErrorViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/11.
//

import Foundation
import UIKit

class CommonErrorViewController: UIViewController {
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    var data: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = UIColor(rgb: 0x333333).withAlphaComponent(0.7)
        
        self.alertView.layer.borderWidth = 1
        self.alertView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.alertView.layer.cornerRadius = 5
        
        self.alertButton.layer.borderWidth = 1
        self.alertButton.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.alertButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5.0)
    }
    
    func configure(_ data: Any?) {
        guard let data = data as? DI_Alert else { return }
        self.data = data
        self.alertLabel.text = data.infoLabel
        self.alertButton.setTitle(data.leftLabel, for: .normal)
    }
    
    
    @IBAction func onButton(_ sender: UIButton) {
        guard let data = data as? DI_Alert else { return }
        data.leftAction?("",nil)
        self.dismiss(animated: false, completion: nil)
    }
}
