//
//  DI_Mail.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/12.
//

import Foundation

enum MailCallbackType: String, CaseIterable {
    case letterDetail
    case bookmark
    case lock
}

class DI_MailList: Codable {
    var resultList: [DI_Mail] = []
}

class DI_Mail: Codable {
    var letterId: Int = 0
    var platformId: Int = 0
    var platformName: String = ""
    var platformImageUrl: String = ""
    var bookmarkId: Int = 0
    var title: String = ""
    var content: String? = ""
    var thumbnailImageUrl: String? = ""
    var bookmarkCount: Int = 0
    var createdAt: String = ""
    var modifiedAt: String = ""
    var isSubscribing: Int? = 1
    
    //custom
    var rankingLabel: String?
}
