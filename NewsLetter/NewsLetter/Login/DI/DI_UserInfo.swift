//
//  DI_UserInfo.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/10.
//

import Foundation

class DI_UserInfo: Codable {
    var userId: String = ""
    var email: String = ""
    var nickname: String = ""
    var password: String = ""
    var bookmarkCount: Int = 0
    var subscribingPlatformCount: Int = 0
}