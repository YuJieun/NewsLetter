//
//  HomeFilterBarCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/16.
//

import UIKit

class HomeFilterBarCell: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onFilterButton(_ sender: UIButton) {
    }
    
    func configure(data: Any? = nil) {
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 40)
    }
    
}
