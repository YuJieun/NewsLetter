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

    var data: DI_Mail?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? DI_Mail else { return }
        self.data = data
        self.updateUI()
        self.bind()
    }
    
    func updateUI() {
        guard let data = self.data else { return }

        //1. 레이아웃
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5

        //2. 북마크
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkLine"), for: .normal)
        self.bookMarkButton.setImage(UIImage(named: "32BookmarkFill"), for: .selected)
    }

    func bind() {
        self.bannerImageView.image = UIImage(named: ConstGroup.BANNERIMG[0])
        self.bannerTitleLabel.text = data.title
        self.bannerLogoImageView.load(urlStr: data.platformImageUrl)
        self.bannerBrandLabel.text = data.platformName
        self.bannerDateLabel.text = data.createdAt

        if data.bookmarkId >= 1 {
            self.bookmarkButton.isSelected = true
        }
        else {
            self.bookmarkButton.isSelected = false
        }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return self.getXibSize(className: "BigLetterBannerCell")
    }
    
    @IBAction func onLetterButton(_ sender: UIButton) {
        cellClosure?("letter",nil)
    }
    
    @IBAction func onBookMarkButton(_ sender: UIButton) {
        guard let data = self.data else { return }
        if self.bookMarkButton.isSelected {
            //북마크 해제
            DataRequest.deleteBookMark(bookmarkId: data.bookmarkId) { [weak self] _ in
                guard let `self` = self else { return }
                self.bookMarkButton.isSelected = false
                cellClosure?(MailCallbackType.bookmark.rawValue, nil)
                #warning("북마크 하고 전체 reload때리는게 과연 맞는가?")
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
        else {
            //북마크 추가
            DataRequest.postAddBookMark(letterId: data.letterId) { [weak self] _ in
                guard let `self` = self else { return }
                self.bookMarkButton.isSelected = true
                cellClosure?(MailCallbackType.bookmark.rawValue, nil)
            } failure: { _ in
                print("북마크 추가 오류")
            }
        }
    }
}


