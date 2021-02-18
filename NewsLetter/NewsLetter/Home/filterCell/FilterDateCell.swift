//
//  FilterDateCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit
import DatePickerDialog

class FilterDateCell: CommonCollectionViewCell {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //https://github.com/squimer/DatePickerDialog-iOS-Swift 라이브러리 사용
    
    func configure(data: Any? = nil) {
        guard let _ = data else { return }

    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 200)
    }

    @IBAction func onStartDateButton(_ sender: UIButton) {
        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("Start Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                self.startDate.text = formatter.string(from: dt)
            }
        }
    }

    @IBAction func onEndDateButton(_ sender: UIButton) {
        let today = Date()
        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("End Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", maximumDate: today, datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                self.endDate.text = formatter.string(from: dt)
            }
        }
    }
}


// 나중에 해야할 것
/*
    1. startDate부터 선택하도록 바꾸기 : 시작일을 먼저 입력해주세요
    2. endDate가 startDate 보다 무조건 크도록
    3. 둘다 잘 입력되어야 날짜 필터링 되도록
    4. startDate끝나면 endDate 다이얼로그도 자동 띄우기
 
 */
