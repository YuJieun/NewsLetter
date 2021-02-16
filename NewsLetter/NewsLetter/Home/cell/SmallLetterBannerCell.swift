//
//  SmallLetterBannerCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/16.
//

import UIKit

class SmallLetterBannerCell: CommonCollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerLogoImageView: UIImageView!
    @IBOutlet weak var bannerInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Any? = nil) {
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 100)
    }
    
    @IBAction func onBookmarkButton(_ sender: UIButton) {
    }
    
}
