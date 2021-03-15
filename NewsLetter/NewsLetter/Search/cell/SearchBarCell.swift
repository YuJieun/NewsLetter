//
//  SearchBarCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class SearchBarCell: CommonCollectionViewCell{

    @IBOutlet weak var searchBar: UISearchBar!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchBar.delegate = self
        configureUI()
    }

    //https://devmjun.github.io/archive/SearchController
    
    func configure(data: Any? = nil) {
    }
    
    func configureUI() {
        searchBar.layer.borderColor = UIColor(rgb: 0x333333).cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 3
        searchBar.setImage(UIImage(named: "14SearchLine"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "14X"), for: .clear, state: .normal)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white

            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0xbdbdbd), NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)])
            textfield.textColor = UIColor(rgb: 0x333333)
            textfield.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: self.getXibSize(className: "SearchBarCell").height)
    }

}

extension SearchBarCell: UISearchBarDelegate, UIGestureRecognizerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.isValid {
            //한글자라도 있으면 키워드검색
            cellClosure?("keyword",text)
            print(text)
        }
        else {
            //빈칸으로 검색시, 다시 조건없이 화면 업데이트
            cellClosure?("all",nil)
            print("all")
        }
        self.searchBar.resignFirstResponder()
    }
}
