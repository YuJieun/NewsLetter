//
//  Padding48Px.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/04/01.
//

import UIKit

class Padding48Px: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Any? = nil) {
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 48)
    }

}
