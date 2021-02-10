//
//  CommonCollectionViewCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/09.
//

import Foundation
import UIKit

class CommonCollectionViewCell: UICollectionViewCell {
    
    var cellClosure: CellClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
