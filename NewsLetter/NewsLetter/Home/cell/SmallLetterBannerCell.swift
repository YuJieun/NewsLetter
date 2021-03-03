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
    @IBOutlet weak var bannerBookmarkView: UIView!
    @IBOutlet weak var bannerBrandLabel: UILabel!
    @IBOutlet weak var bannerDateLabel: UILabel!
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var bannerBorderView: UIView!
    
    @IBOutlet weak var rankingView: UIView!
    @IBOutlet weak var rankingLabel: UILabel!
    
    var isLock: Bool = false
    var isRankingVisible = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
        
        updateUI()
//        guard let _ = data else { return }
        if isLock {
            self.lockView.isHidden = false
        }
        else {
            self.lockView.isHidden = true
        }
        
        if isRankingVisible {
            configureRankingUI()
            self.rankingView.isHidden = false
            if let data = data as? String {
                self.rankingLabel.text = data
            }
        }
        else {
            self.rankingView.isHidden = true
        }
    }
    
    func configureRankingUI(){
        self.rankingView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.rankingView.layer.borderWidth = 1
        self.rankingView.roundCorners(corners: [.topLeft], radius: 5.0)
    }
    
    func updateUI() {
        self.bannerBorderView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.bannerBorderView.layer.borderWidth = 1
        self.bannerBorderView.layer.cornerRadius = 5
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SmallLetterBannerCell").height)
    }
    
    @IBAction func onBookmarkButton(_ sender: UIButton) {
        
    }

    @IBAction func onLockButton(_ sender: UIButton) {
        //https://stackoverflow.com/questions/44719277/alertcontroller-with-white-borders
        guard isLock == true else { return }
        let alert: UIAlertController = UIAlertController(title: "알림", message: "해당 레터를 보려면 구독이 필요해요!\n지은을 구독하시겠습니까?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "취소", style: .destructive) { (action) in }
        let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in }
        alert.addAction(cancleAction)
        alert.addAction(okAction)
        alert.show()
    
    }
    
}
