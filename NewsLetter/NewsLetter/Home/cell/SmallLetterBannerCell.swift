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
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var isLock: Bool = false
    var isRankingVisible = false
    
    var row: Int = 0
    
    var data: DI_Mail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        guard let data = data as? DI_Mail else { return }
        self.data = data
        
        updateUI()
//        updateTmp()
        self.bannerImageView.image = UIImage(named: ConstGroup.BANNERIMG[0])
        self.bannerTitleLabel.text = data.title
        self.bannerLogoImageView.load(urlStr: data.platformImageUrl)
        self.bannerBrandLabel.text = data.platformName
        self.bannerDateLabel.text = data.createdAt
    }
    
    func tmpConfigure() {
        self.bookmarkButton.setImage(UIImage(named: "24BookmarkFill"), for: .normal)
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
        
        self.bookmarkButton.setImage(UIImage(named: "24BookmarkLine"), for: .normal)
        self.bookmarkButton.setImage(UIImage(named: "24BookmarkFill"), for: .selected)
        
        if isLock {
            self.lockView.isHidden = false
        }
        else {
            self.lockView.isHidden = true
        }
        
        if isRankingVisible {
            configureRankingUI()
            self.rankingView.isHidden = false
            if let data = self.data, let ranking = data.rankingLabel{
                self.rankingLabel.text = ranking
            }
        }
        else {
            self.rankingView.isHidden = true
        }
    }
    
//    func updateTmp() {
//        self.bannerImageView.image = UIImage(named: ConstGroup.BANNERIMG[row])
//        self.bannerTitleLabel.text = ConstGroup.BANNERTXT[row]
//        self.bannerLogoImageView.image = UIImage(named: ConstGroup.LOGOIMG[row])
//        self.bannerBrandLabel.text = ConstGroup.LOGOTXT[row]
//        self.bannerDateLabel.text = ConstGroup.DATETXT[row]
//    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SmallLetterBannerCell").height)
    }
    
    @IBAction func onBookmarkButton(_ sender: UIButton) {
        self.bookmarkButton.isSelected = !self.bookmarkButton.isSelected
    }

    @IBAction func onLockButton(_ sender: UIButton) {
        //https://stackoverflow.com/questions/44719277/alertcontroller-with-white-borders
        guard isLock == true else { return }
//        let alert: UIAlertController = UIAlertController(title: "알림", message: "해당 레터를 보려면 구독이 필요해요!\n지은을 구독하시겠습니까?", preferredStyle: .alert)
//        let cancleAction = UIAlertAction(title: "취소", style: .destructive) { (action) in }
//        let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in }
//        alert.addAction(cancleAction)
//        alert.addAction(okAction)
//        alert.show()
        cellClosure?("lock", nil)
    
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        cellClosure?("letter",nil)
    }
}
