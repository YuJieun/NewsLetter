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
    var row: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
        self.brandTitleLabel.text = ConstGroup.LOGOTXT[row]
        self.logoImage.image = UIImage(named: ConstGroup.LOGOIMG[row])
        self.bottomView.isHidden = !isBottomViewVisible
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SubscribeLetterCell").height)
    }

    @IBAction func onDeleye(_ sender: UIButton) {
        
    }
}
