//
//  SearchTitleCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class SearchTitleCell: CommonCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? String else { return }
        self.titleLabel.text = data
    }



    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SearchTitleCell").height)
    }
}
