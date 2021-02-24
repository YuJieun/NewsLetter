//
//  FilterDateCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit
import DatePickerDialog

class DI_FilterDate {
    var startData: Date?
    var endData: Date?
}

class FilterDateCell: CommonCollectionViewCell {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    var filterDate: DI_FilterDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //https://github.com/squimer/DatePickerDialog-iOS-Swift 라이브러리 사용
    
    func configure(data: Any? = nil) {
//        guard let _ = data else { return }
        self.filterDate = DI_FilterDate()

    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 200)
    }

    @IBAction func onStartDateButton(_ sender: UIButton) {
        let today = Date()
        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("Start Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", minimumDate: nil, maximumDate: today, datePickerMode: .date) { date in
            if let dt = date {
                guard let filterDate = self.filterDate else { return }
                filterDate.startData = dt
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                self.startDate.text = formatter.string(from: dt)
            }
        }
    }

    @IBAction func onEndDateButton(_ sender: UIButton) {
        guard let filterDate = self.filterDate else { return }
        if filterDate.startData == nil {
            let alert: UIAlertController = UIAlertController(title: "알림", message: "시작날짜를 먼저 입력해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in }
            alert.addAction(okAction)
            alert.show()
        }
        else {
            let today = Date()
            DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("End Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", minimumDate: filterDate.startData, maximumDate: today, datePickerMode: .date) { date in
                if let dt = date {
                    filterDate.endData = dt
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd"
                    self.endDate.text = formatter.string(from: dt)
                    
                    self.cellClosure?("",self.filterDate)
                }
            }
        }
    }

}


// 나중에 해야할 것
/*
    1. 필터 초기화기능이 필요해보임.
 
 */
