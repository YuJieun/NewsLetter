//
//  BigLetterBannerCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/16.
//

import UIKit
import Kingfisher

class BigLetterBannerCell: CommonCollectionViewCell {

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerLogoImageView: UIImageView!
    @IBOutlet weak var bannerBrandLabel: UILabel!
    @IBOutlet weak var bannerDateLabel: UILabel!
    @IBOutlet weak var bannerBookMarkButton: UIView!
    @IBOutlet weak var bookMarkButton: UIButton!

    var data: DI_Mail?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateUI()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? DI_Mail else { return }
        self.data = data
        self.bind()
    }
    
    func updateUI() {
        //1. 레이아웃
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5

        //2. 북마크
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkLine"), for: .normal)
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkFill"), for: .selected)
    }

    func bind() {
        guard let data = self.data else { return }
        if let thumbnailImageUrl = data.thumbnailImageUrl, thumbnailImageUrl.isValid {
            let url = URL(string: thumbnailImageUrl)
            self.bannerImageView.kf.setImage(with: url)
        }
        else {
            self.bannerImageView.image = UIImage(named: "")
        }
        self.bannerTitleLabel.text = data.title
        
        let logoUrl = URL(string: data.platformImageUrl)
        self.bannerLogoImageView.kf.setImage(with: logoUrl)
        
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
            self.bookMarkButton.isSelected = true
        }
        else {
            self.bookMarkButton.isSelected = false
        }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return self.getXibSize(className: "BigLetterBannerCell")
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        guard let data = self.data else { return }
        cellClosure?(MailCallbackType.letterDetail.rawValue, data)
    }
    
    @IBAction func onBookMarkButton(_ sender: UIButton) {
        guard let data = self.data else { return }
        if self.bookMarkButton.isSelected {
            //북마크 해제
            DataRequest.deleteBookMark(bookmarkId: data.bookmarkId) { [weak self] in
                guard let `self` = self else { return }
                self.bookMarkButton.isSelected = false
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
        else {
            //북마크 추가
            DataRequest.postAddBookMark(letterId: data.letterId) { [weak self] in
                guard let `self` = self else { return }
                self.bookMarkButton.isSelected = true
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
    }
}


