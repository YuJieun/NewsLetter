//
//  HomeTitleCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/09.
//

import UIKit

class HomeTitleCell: CommonCollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var data: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? String else { return }
        self.data = data
        self.nameLabel.text = data
    }

 
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 118)
    }
}
