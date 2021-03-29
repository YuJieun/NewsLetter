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
    @IBOutlet weak var button: UIButton!
    
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
        
        if let subscribing = data.subscribing {
            if subscribing {
                button.setImage(UIImage(named: "deleteFill"), for: .normal)
            }
            else {
                button.setImage(UIImage(named: "addFill"), for: .normal)
            }
        }
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SubscribeLetterCell").height)
    }

    @IBAction func onButton(_ sender: UIButton) {
        guard let data = self.data else { return }
        guard let subscribing = data.subscribing else { return }
        
        if subscribing {
            DataRequest.deletePlatform(id: data.platformId) { [weak self] data in
                guard let self = self else { return }
                self.cellClosure?("",nil)
            } failure: { _ in
                print("플랫폼목록 못가져옴")
            }
        }
        else {
            DataRequest.addPlatform(id: data.platformId) { [weak self] data in
                guard let self = self else { return }
                self.cellClosure?("",nil)
            } failure: { _ in
                print("플랫폼목록 못가져옴")
            }
        }
    }
}
