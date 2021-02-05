//
//  LoginManager.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import Foundation

public typealias LoginActionCallback = (_ status: Bool) -> Void

public class LoginManager {
    public static let shared = LoginManager()
    public var memberInfo: DI_MemberInfo

    private init() {
        self.memberInfo = DI_MemberInfo()
    }
    
    //Any를 DI_LoginAction로 바꾸기
    public func ssgLoginAction(loginActionData: Any? = nil, _ callBack: LoginActionCallback){
        if let loginActionData = loginActionData {
            //일반로그인인 경우
        }
        else {
            //자동로그인인 경우
//            dataClass.mbrLoginId = self.memberInfo.memberID()
//            dataClass.password = self.memberInfo.memberPassword() 이걸로 로그인 요청하기
        }
        
    }

}

public class DI_MemberInfo {
    public var memberName: String = ""
    
    public func isAutoLoginAction() -> Bool {
        if self.isSaveAutoLogin() {
            if self.memberPassword().isValid {
                return true
            }
        }

        return false
    }
    
    public func isSaveAutoLogin() -> Bool {
        guard let memberInfo: [String: Any] = self.getMemberInfo() else { return true }
        guard let isSaveAutoLogin: Bool = memberInfo[ConstGroup.KEYCHAIN_MEMBER_AUTOLOGIN_OPTION] as? Bool else {
            return true
        }
        return isSaveAutoLogin
    }
    
    public func getMemberInfo() -> [String: Any]? {
        guard let bundleIdentifier: String = Bundle.main.bundleIdentifier else { return nil }
        guard let value: String = KeychainService.shared.load(bundleIdentifier)  else { return nil }
        let dic = value.toDictionary()
        let memberDic = dic?[ConstGroup.KEYCHAIN_MEMBER_INFO] as? [String: Any]
        return memberDic
    }
    
    public func memberPassword() -> String {
        guard let memberInfo: [String: Any] = self.getMemberInfo() else { return "" }

        if let passwd: String = memberInfo[ConstGroup.KEYCHAIN_MEMBER_PASSWORD] as? String {
//            guard passwd.isValid, let decPasswd = WG_UtilSecurity.aes256DecryptWithString(passwd) else {
//                return ""
//            }
//            return decPasswd
            guard passwd.isValid else { return "" }
            return passwd
        }
        return ""
    }
    
    public func memberID() -> String {
        guard let memberInfo: [String: Any] = self.getMemberInfo() else { return "" }

        if let memberID: String = memberInfo[ConstGroup.KEYCHAIN_MEMBER_ID] as? String {
//            guard memberID.isValid, let decMemberId = WG_UtilSecurity.aes256DecryptWithString(memberID) else {
//                return ""
//            }
            guard memberID.isValid else { return "" }
            return memberID
        }
        return ""
    }
}
