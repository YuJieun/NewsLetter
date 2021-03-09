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
    @IBOutlet weak var bookMarkButton: UIButton!
    
    var row: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkLine"), for: .normal)
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkFill"), for: .selected)
    }
    
    func updateTmp() {
        self.bannerImageView.image = UIImage(named: ConstGroup.BANNERIMG[row])
        self.bannerTitleLabel.text = ConstGroup.BANNERTXT[row]
        self.bannerLogoImageView.image = UIImage(named: ConstGroup.LOGOIMG[row])
        self.bannerBrandLabel.text = ConstGroup.LOGOTXT[row]
        self.bannerDateLabel.text = ConstGroup.DATETXT[row]
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
        updateUI()
        updateTmp()
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return self.getXibSize(className: "BigLetterBannerCell")
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        cellClosure?("letter",nil)
    }
    
    @IBAction func onBookMarkButton(_ sender: UIButton) {
        self.bookMarkButton.isSelected = !self.bookMarkButton.isSelected
    }
}
