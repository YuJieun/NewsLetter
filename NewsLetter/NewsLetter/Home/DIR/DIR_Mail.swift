//
//  DIR_Mail.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/16.
//

import Foundation

class DIR_Mail: Codable {
    var startDate: String? = ""
    var endDate: String = ""
    var page: Int = 0
    var platforms:[String] = []
}
