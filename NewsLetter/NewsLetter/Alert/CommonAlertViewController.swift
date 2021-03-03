//
//  CommonAlertViewController.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/01.
//

import UIKit

class CommonAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
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
        
        self.leftButton.layer.borderWidth = 1
        self.leftButton.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.leftButton.roundCorners(corners: [.bottomLeft], radius: 5.0)
        
        self.rightButton.layer.borderWidth = 1
        self.rightButton.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.rightButton.roundCorners(corners: [.bottomRight], radius: 5.0)
    }
    
    func configure(_ data: Any?) {
        guard let data = data as? DI_Alert else { return }
        self.data = data
        self.infoLabel.text = data.infoLabel
        self.rightButton.setTitle(data.rightLabel, for: .normal)
        self.leftButton.setTitle(data.leftLabel, for: .normal)
    }
    
    
    @IBAction func onLeftButton(_ sender: UIButton) {
        guard let data = data as? DI_Alert else { return }
        data.leftAction?("",nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onRightButton(_ sender: UIButton) {
        guard let data = data as? DI_Alert else { return }
        data.rightAction?("",nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.alertView {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
