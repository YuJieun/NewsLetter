//
//  MemberManager.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/03/11.
//

import Foundation

class MemberManager {
    static let shared = MemberManager()
    private init() {}
    
    private var nickname: String = ""
    
    func setNickName(_ name: String) {
        self.nickname = name
    }
    
    func getNickName() -> String {
        return self.nickname
    }
}
