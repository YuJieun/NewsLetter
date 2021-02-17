//
//  SearchBarCell.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/17.
//

import UIKit

class SearchBarCell: CommonCollectionViewCell {

    @IBOutlet weak var searchBar: UISearchBar!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //https://devmjun.github.io/archive/SearchController
    
    func configure(data: Any? = nil) {
//        guard let data = data as? String else { return }
    }

    class func getSize(_ data: Any? = nil) -> CGSize {
        return CGSize(width: UISCREEN_WIDTH, height: 50)
    }

}
