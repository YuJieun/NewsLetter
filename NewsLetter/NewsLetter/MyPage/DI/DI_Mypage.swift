//
//  DI_Mypage.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/24.
//

import Foundation

class DI_BookMarkList: Codable {
    var bookmarkList: [DI_BookMark]
}
class DI_BookMark: Codable {
    var bookmarkCount: Int = 0
    var createdAt: String = ""
    var isSubscribing: Int = 0
    var letterId: Int = 0
    var modifiedAt: String = ""
    var platformId: Int = 0
    var platformImageUrl: String = ""
    var platformName: String = ""
    var thumbnailImageUrl: String = ""
    var title: String = ""
}
