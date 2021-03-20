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
    
    var data: DI_Mail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        guard let data = data as? DI_Mail else { return }
        self.data = data
        
        updateUI()

        self.bannerImageView.image = UIImage(named: ConstGroup.BANNERIMG[0])
        self.bannerTitleLabel.text = data.title
        self.bannerLogoImageView.load(urlStr: data.platformImageUrl)
        self.bannerBrandLabel.text = data.platformName
        
        let dateString:String = data.createdAt
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date:Date = dateFormatter.date(from: dateString)!

        dateFormatter.dateFormat = "MM/dd/yyyy"
        let createDate = dateFormatter.string(from: date)

        self.bannerDateLabel.text = createDate

        if data.bookmarkId >= 1 {
            self.bookmarkButton.isSelected = true
        }
        else {
            self.bookmarkButton.isSelected = false
        }
    }
    
    func configureRankingUI(){
        self.rankingView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.rankingView.layer.borderWidth = 1
        self.rankingView.roundCorners(corners: [.topLeft], radius: 5.0)
    }
    
    func updateUI() {
        guard let data = self.data else { return }
        //1: 배너
        self.bannerBorderView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.bannerBorderView.layer.borderWidth = 1
        self.bannerBorderView.layer.cornerRadius = 5

        //2: 북마크
        self.bookmarkButton.setImage(UIImage(named: "24BookmarkLine"), for: .normal)
        self.bookmarkButton.setImage(UIImage(named: "24BookmarkFill"), for: .selected)

        //3: 잠금
        if let subscribing = data.subscribing, subscribing == false {
            self.lockView.isHidden = false
        }
        else {
            self.lockView.isHidden = true
        }

        //4: 랭킹
        if let ranking = data.rankingLabel, ranking.isValid {
            self.rankingView.isHidden = false
            configureRankingUI()
            self.rankingLabel.text = ranking
        }
        else {
            self.rankingView.isHidden = true
        }
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SmallLetterBannerCell").height)
    }
    
    @IBAction func onBookmarkButton(_ sender: UIButton) {
        guard let data = self.data else { return }
        if self.bookmarkButton.isSelected {
            //북마크 해제
            DataRequest.deleteBookMark(bookmarkId: data.bookmarkId) { [weak self] in
                guard let `self` = self else { return }
                self.bookmarkButton.isSelected = false
                self.cellClosure?(MailCallbackType.bookmark.rawValue, nil)
                #warning("북마크 하고 전체 reload때리는게 과연 맞는가?")
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
        else {
            //북마크 추가
            DataRequest.postAddBookMark(letterId: data.letterId) { [weak self] in
                guard let `self` = self else { return }
                self.bookmarkButton.isSelected = true
                self.cellClosure?(MailCallbackType.bookmark.rawValue, nil)
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
    }

    @IBAction func onLockButton(_ sender: UIButton) {
        if let subscribing = self.data?.subscribing, subscribing == false {
            cellClosure?(MailCallbackType.lock.rawValue, data)
        }
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        cellClosure?(MailCallbackType.letterDetail.rawValue, data)
    }
}
