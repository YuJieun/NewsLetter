//
//  FilterCalendarCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/09.
//

import UIKit
import FSCalendar

class FilterCalendarCell: CommonCollectionViewCell {

    @IBOutlet weak var calendarView: FSCalendar!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Any? = nil) {
        guard let _ = data else { return }
        setCalendar()
    }
    
    func setCalendar() {
        calendarView.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        calendarView.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        calendarView.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)

        
        calendarView.allowsMultipleSelection = true
        calendarView.swipeToChooseGesture.isEnabled = true
    }
    
    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 200
        )
    }

}
