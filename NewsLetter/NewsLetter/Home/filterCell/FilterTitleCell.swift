//
//  FilterTitleCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterTitleCell: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: Any? = nil) {
        guard let _ = data else { return }

    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 62)
    }


    @IBAction func onStartDateButton(_ sender: UIButton) {
        cellClosure?("", nil)
    }
}
