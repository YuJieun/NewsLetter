//
//  FilterBrandItemCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class FilterBrandItemCell: CommonCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var data: DI_Platform?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    func configure(data: Any? = nil) {
        guard let data = data as? DI_Platform else { return }
        self.data = data
        self.titleLabel.text = data.name
        
        if data.isSelected ?? false {
            self.backView.backgroundColor = UIColor(rgb: 0xffdccc)
            self.brandButton.isSelected = true
        }
        else {
            self.backView.backgroundColor = UIColor(rgb: 0xffffff)
            self.brandButton.isSelected = false
        }
    }
    
    func updateUI() {
        self.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        guard let data = data as? DI_Platform else { return .zero }
        let cell = Self.getXib(className: "FilterBrandItemCell", as: self)
        let width = data.name.width(withConstrainedHeight: 34, font: cell.titleLabel.font)
        
        return CGSize(width: width + 24, height: 34)
    }

    @IBAction func onButton(_ sender: UIButton) {
        guard let data = self.data, data.name != "전체" else { return }
        if self.brandButton.isSelected {
            data.isSelected = false
            self.cellClosure?("delete", data)
        }
        else {
            data.isSelected = true
            self.cellClosure?("add", data)
        }
    }
    
}
