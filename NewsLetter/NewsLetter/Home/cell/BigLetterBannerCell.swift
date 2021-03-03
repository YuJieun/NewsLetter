//
//  BigLetterBannerCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/16.
//

import UIKit

class BigLetterBannerCell: CommonCollectionViewCell {

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerLogoImageView: UIImageView!
    @IBOutlet weak var bannerBrandLabel: UILabel!
    @IBOutlet weak var bannerDateLabel: UILabel!
    @IBOutlet weak var bannerBookMarkButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
        updateUI()
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return self.getXibSize(className: "BigLetterBannerCell")
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        cellClosure?("letter",nil)
    }
    
    @IBAction func onBookMarkButton(_ sender: UIButton) {
    }
}
