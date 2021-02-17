//
//  FilterDateCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterDateCell: CommonCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //https://github.com/squimer/DatePickerDialog-iOS-Swift 이거 쓰기
    //https://www.swiftdevcenter.com/uidatepicker-as-input-view-to-uitextfield-swift/

    func configure(data: Any? = nil) {
        guard let _ = data else { return }

    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 200)
    }

    @IBAction func onStartDateButton(_ sender: UIButton) {

    }

    @IBAction func onEndDateButton(_ sender: UIButton) {

    }
}
