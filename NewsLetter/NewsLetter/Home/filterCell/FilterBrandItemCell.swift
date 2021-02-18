//
//  FilterBrandItemCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterBrandItemCell: CommonCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? String else { return }
        self.titleLabel.text = data
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        guard let data = data as? String else { return .zero }
        let cell = Self.fromNib(className: "FilterBrandItemCell", as: self)
        let width = data.width(withConstrainedHeight: 25, font: cell.titleLabel.font)
        
        return CGSize(width: width + 24, height: 25)
    }


}
