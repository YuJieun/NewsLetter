//
//  MypageProfileCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import UIKit

class MypageProfileCell: CommonCollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        self.nameLabel.text = MemberManager.shared.getNickName()
        self.emailLabel.text = MemberManager.shared.getEmail()
    }

    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "MypageProfileCell").height)
    }
    

    @IBAction func onSettingButton(_ sender: UIButton) {
        cellClosure?("",nil)
    }
    
}
