//
//  HomeNoLetterCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/01.
//

import UIKit

class HomeNoLetterCell: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "HomeNoLetterCell").height)
    }

}
