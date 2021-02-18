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
    @IBOutlet weak var lockView: UIView!
    
    var isLock: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Any? = nil) {
        guard let _ = data else { return }
        if isLock {
            self.lockView.isHidden = false
        }
        else {
            self.lockView.isHidden = true
        }
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 100)
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
