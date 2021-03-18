//
//  SubscribeLetterCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/18.
//

import UIKit

class SubscribeLetterCell: CommonCollectionViewCell {

    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    var isBottomViewVisible: Bool = true
    var data: DI_Platform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        guard let data = data as? DI_Platform else { return }
        self.data = data
        self.brandTitleLabel.text = data.name
        self.logoImage.load(urlStr: data.imageUrl)
        self.bottomView.isHidden = !isBottomViewVisible
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SubscribeLetterCell").height)
    }

    @IBAction func onDelete(_ sender: UIButton) {
        guard let data = self.data else { return }
//        DataRequest.deletePlatform(id: data.platformId) { [weak self] data in
//            guard let `self` = self else { return }
//            print("구독삭제성공")
//        } failure: { _ in
//            print("플랫폼목록 못가져옴")
//        }
    }
}
