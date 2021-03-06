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
    private var userId: Int = 0
    private var email: String = ""
    
    func setNickName(_ name: String) {
        self.nickname = name
    }
    
    func getNickName() -> String {
        return self.nickname
    }
    
    func setUserId(_ id: Int) {
        self.userId = id
    }
    
    func getuserId() -> Int {
        return self.userId
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func getEmail() -> String {
        return self.email
    }
}
