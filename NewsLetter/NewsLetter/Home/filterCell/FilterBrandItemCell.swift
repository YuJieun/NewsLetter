//
//  FilterBrandItemCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterBrandItemCell: CommonCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? String else { return }
        updateUI()
        self.titleLabel.text = data
    }
    
    func updateUI() {
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        guard let data = data as? String else { return .zero }
        let cell = Self.getXib(className: "FilterBrandItemCell", as: self)
        let width = data.width(withConstrainedHeight: 34, font: cell.titleLabel.font)
        
        return CGSize(width: width + 24, height: 34)
    }


}
