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
    @IBOutlet weak var startArrow: UIImageView!
    
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var endTitleLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endInfoLabel: UILabel!
    @IBOutlet weak var endArrow: UIImageView!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var data: DIR_Mail?
    var weekdayName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
    
//    var startDate: Date?
//    var endDate: Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //https://github.com/squimer/DatePickerDialog-iOS-Swift 라이브러리 사용
    
    func configure(data: Any? = nil) {
        guard let data = data as? DIR_Mail else { return }
        self.data = data
        self.startView.layer.borderWidth = 1
        self.startView.layer.cornerRadius = 6
        self.endView.layer.borderWidth = 1
        self.endView.layer.cornerRadius = 6
        if data.startDate?.isValid ?? false {
            configureFilterStartUI()
            configureFilterEndUI()
            configureDate()
        }
        else {
            configureDefaultUI()
            configureDefaultDate()
        }
    }
    
    func configureDefaultUI() {
        self.startView.layer.borderColor = UIColor(rgb: 0xbdbdbd).cgColor
        self.startDateLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.startInfoLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.startTitleLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.startArrow.image = UIImage(named: "6DropUnablegray")
        
        self.endView.layer.borderColor = UIColor(rgb: 0xbdbdbd).cgColor
        self.endDateLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.endInfoLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.endTitleLabel.textColor = UIColor(rgb: 0xbdbdbd)
        self.endArrow.image = UIImage(named: "6DropUnablegray")
        
        self.checkBoxButton.isSelected = true
        self.checkBoxImage.image = UIImage(named: "18SquareCheckFill")
    }
    
    func configureFilterStartUI() {
        self.startView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.startDateLabel.textColor = UIColor(rgb: 0x333333)
        self.startInfoLabel.textColor = UIColor(rgb: 0x333333)
        self.startTitleLabel.textColor = UIColor(rgb: 0x333333)
        self.startArrow.image = UIImage(named: "6DropPickygray")
        
        self.checkBoxButton.isSelected = false
        self.checkBoxImage.image = UIImage(named: "18SquareLine")
    }
    
    func configureFilterEndUI() {
        self.endView.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.endDateLabel.textColor = UIColor(rgb: 0x333333)
        self.endInfoLabel.textColor = UIColor(rgb: 0x333333)
        self.endTitleLabel.textColor = UIColor(rgb: 0x333333)
        self.endArrow.image = UIImage(named: "6DropPickygray")

    }
    
    func configureDefaultDate() {
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
    
    func configureDate() {
        guard let data = self.data else { return }
        guard let startDate = data.startDate else { return }
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        do {
            let date:Date = dateFormatter.date(from: startDate)!
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let weekday = calendar.component(.weekday, from: date)
            self.startDateLabel.text = "\(day)"
            self.startInfoLabel.text = "\(year)년 \(month)월\n\(weekdayName[weekday-1])"
        }
        
        do {
            let date:Date = dateFormatter.date(from: data.endDate)!
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let weekday = calendar.component(.weekday, from: date)
            self.endDateLabel.text = "\(day)"
            self.endInfoLabel.text = "\(year)년 \(month)월\n\(weekdayName[weekday-1])"
        }
    }
    

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "FilterDateCell").height)
    }

    @IBAction func oncheckBox(_ sender: UIButton) {
        if checkBoxButton.isSelected == false {
            guard let data = self.data else { return }
            data.startDate = nil
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            let end = Calendar.current.date(byAdding: .day, value: -7, to: Date())
            data.endDate = formatter.string(from: end!)
            cellClosure?("",nil)
        }
    }
    
    @IBAction func onStartDateButton(_ sender: UIButton) {
        guard let endDate = self.data?.endDate else { return }
        let today = Date()
        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("Start Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", minimumDate: nil, maximumDate: today, datePickerMode: .date) { date in
            if let dt = date {
                guard let data = self.data else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let startDate = formatter.string(from: dt)
                data.startDate = startDate
                
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
        guard let startDate = self.data?.startDate, startDate.isValid else {
            let alert: UIAlertController = UIAlertController(title: "알림", message: "시작날짜를 먼저 입력해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in }
            alert.addAction(okAction)
            alert.show()
            return
        }
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let start:Date = dateFormatter.date(from: startDate)!

        DatePickerDialog(locale: Locale(identifier: "ko_KO")).show("End Date", doneButtonTitle: "완료", cancelButtonTitle: "취소", minimumDate: start, maximumDate: today, datePickerMode: .date) { date in
            if let dt = date {
                guard let data = self.data else { return }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let endDate = formatter.string(from: dt)
                data.endDate = endDate
                
                let calendar = Calendar.current
                let year = calendar.component(.year, from: dt)
                let month = calendar.component(.month, from: dt)
                let day = calendar.component(.day, from: dt)
                let weekday = calendar.component(.weekday, from: dt)
                
                self.endDateLabel.text = "\(day)"
                self.endInfoLabel.text = "\(year)년 \(month)월\n\(self.weekdayName[weekday-1])"
                self.configureFilterEndUI()
//              self.cellClosure?("",self.filterDate)
            }
        }
    }

}


// 나중에 해야할 것
/*
    1. 필터 초기화기능이 필요해보임.
 
 */
