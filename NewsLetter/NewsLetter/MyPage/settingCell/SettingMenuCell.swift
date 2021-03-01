//
//  SettingMenuCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import UIKit

class SettingMenuCell: CommonCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        guard let data = data as? String else { return }
        self.titleLabel.text = data
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SettingMenuCell").height)
    }

    @IBAction func onButton(_ sender: UIButton) {
        cellClosure?("",nil)
    }
}
