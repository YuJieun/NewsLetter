//
//  FilterBrandItemCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterBrandItemCell: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: Any? = nil) {
        guard let _ = data else { return }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        //스트링 가변 길이 + 왼쪽 오른쪽 패딩
        return CGSize(width: 50, height: 25)
    }


}
