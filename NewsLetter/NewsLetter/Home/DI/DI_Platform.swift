//
//  DI_Platform.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/17.
//

import Foundation

class DI_PlatformList: Codable {
    var resultList:[DI_Platform] = []
}

class DI_Platform: Codable {
    var imageUrl: String = ""
    var name: String = ""
    var platformId: Int = 0
    var subscribing: Bool? = false

    
    //custom
    var isSelected: Bool? = false
}
