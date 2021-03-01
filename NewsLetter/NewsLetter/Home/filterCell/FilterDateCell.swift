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
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var startTitleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startInfoLabel: UILabel!
    
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var endTitleLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endInfoLabel: UILabel!
    
    var filterDate: DI_FilterDate?
    var weekdayName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //https://github.com/squimer/DatePickerDialog-iOS-Swift 라이브러리 사용
    
    func configure(data: Any? = nil) {
        guard let data = data as? DI_FilterDate else { return }
        self.filterDate = data
        configureDefaultUI()
        configureDate()
    }
    
    func configureDefaultUI() {
        self.startView.layer.borderColor = UIColor(rgb: 0xbdbdbd).cgColor
        self.startView.layer.borderWidth = 1
        self.startView.layer.cornerRadius = 6
        self.startDateLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.startInfoLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.startTitleLabel.textColor = UIColor(rgb: 0xbdbdbd)
        
        self.endView.layer.borderColor = UIColor(rgb: 0xbdbdbd).cgColor
        self.endView.layer.borderWidth = 1
        self.endView.layer.cornerRadius = 6
        self.endDateLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.endInfoLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.endTitleLabel.textColor = UIColor(rgb: 0xbdbdbd)
        
        self.checkBoxImage.image = UIImage(named: "18SquareCheckFill")
    }
    
    func configureFilterStartUI() {
        self.startView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.startDateLabel.textColor = UIColor(rgb: 0x333333)
        self.startInfoLabel.textColor = UIColor(rgb: 0x333333)
        self.startTitleLabel.textColor = UIColor(rgb: 0x333333)
        
        self.checkBoxImage.image = UIImage(named: "18SquareLine")
    }
    
    func configureFilterEndUI() {
        self.endView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.endDateLabel.textColor = UIColor(rgb: 0x333333)
        self.endInfoLabel.textColor = UIColor(rgb: 0x333333)
        self.endTitleLabel.textColor = UIColor(rgb: 0x333333)
    }
    
    func configureDate() {
        let calendar = Calendar.current
        let date = Date()
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let weekday = calendar.component(.weekday, from: date)
        self.startDateLabel.text = "\(day)"
        self.startInfoLabel.text = "\(year)년 \(month)월\n\(weekdayName[weekday-1])"
        
        self.endDateLabel.text = "\(day)"
        self.endInfoLabel.text = "\(year)년 \(month)월\n\(weekdayName[weekday-1])"
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "FilterDateCell").height)
    }

    @IBAction func onStartDateButton(_ sender: UIButton) {
        let today = Date()
        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("Start Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", minimumDate: nil, maximumDate: today, datePickerMode: .date) { date in
            if let dt = date {
                guard let filterDate = self.filterDate else { return }
                filterDate.startData = dt
                
                let calendar = Calendar.current
                let year = calendar.component(.year, from: dt)
                let month = calendar.component(.month, from: dt)
                let day = calendar.component(.day, from: dt)
                let weekday = calendar.component(.weekday, from: dt)
                
                self.startDateLabel.text = "\(day)"
                self.startInfoLabel.text = "\(year)년 \(month)월\n\(self.weekdayName[weekday-1])"
                self.configureFilterStartUI()
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
                    
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: dt)
                    let month = calendar.component(.month, from: dt)
                    let day = calendar.component(.day, from: dt)
                    let weekday = calendar.component(.weekday, from: dt)
                    
                    self.endDateLabel.text = "\(day)"
                    self.endInfoLabel.text = "\(year)년 \(month)월\n\(self.weekdayName[weekday-1])"
                    self.configureFilterEndUI()

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
