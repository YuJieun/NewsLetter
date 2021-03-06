//
//  DataRequest.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/06.
//

import Foundation
import Alamofire


class DataRequest {
    static func handleErrorType(_ errType: FailureResult, _ data: Any?, _ closure: @escaping (Error?) -> Void) {
        switch errType {
        case .network :
            guard let topView = UIApplication.topViewController() else { return }
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonErrorViewController") as? CommonErrorViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            topView.present(vc, animated: false){
                let alertData = DI_Alert()
                alertData.infoLabel = "네트워크에 연결할 수 없습니다."
                alertData.leftLabel = "확인"
                alertData.leftAction = {  _, _ in
                    print("네트워크 에러")
                }
                vc.configure(alertData)
            }
            
        case .custom :
            guard let topView = UIApplication.topViewController() else { return }
            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "CommonErrorViewController") as? CommonErrorViewController else { return }
            guard let data = data as? String else { return }
            vc.modalPresentationStyle = .overFullScreen
            topView.present(vc, animated: false){
                let alertData = DI_Alert()
                alertData.infoLabel = data
                alertData.leftLabel = "확인"
                alertData.leftAction = {  _, _ in
                    closure(nil)
                }
                vc.configure(alertData)
            }
        }
    }

    //MARK:- 회원가입
    static func postJoin(param: DIR_User, success: @escaping (DI_User) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.JOIN_URL
        let parameter = param.dictionary
        ApiManager.shared.requestApi(url, parameter, DI_User.self, .post,  success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    //이메일 중복체크
    static func postEmailCheck(email: String, success: @escaping (DI_Common) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.EMAIL_URL
        let parameter = ["email" : email]
        ApiManager.shared.requestApi(url, parameter, DI_Common.self, .post, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //계정 삭제
    static func deleteAccount(success: @escaping (DI_UserInfo) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.USERINFO_URL
        ApiManager.shared.requestApi(url, nil, DI_UserInfo.self, .delete, isContainToken: true,  success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 로그인
    static func postLogin(param: DIR_User, success: @escaping (DI_User) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.LOGIN_URL
        let parameter = param.dictionary
        ApiManager.shared.requestApi(url, parameter, DI_User.self, .post, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    //사용자 정보 가져오기
    static func getUserInfo(success: @escaping (DI_UserInfo) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.USERINFO_URL
        ApiManager.shared.requestApi(url, nil, DI_UserInfo.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 메일목록
    static func getMailList(parameter: DIR_Mail, success: @escaping (DI_MailList) -> Void, failure: @escaping (Error?) -> Void ) {
        let userId = MemberManager.shared.getuserId()
        let url = "\(ConstGroup.USERINFO_URL)/\(userId)/mailbox"
        ApiManager.shared.requestApiClassParam(url, parameter, DI_MailList.self, DIR_Mail.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    static func getMailRankingList(success: @escaping (DI_MailList) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.RANKING_URL
        ApiManager.shared.requestApi(url, nil, DI_MailList.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    static func getMailSearch(keyword: String, success: @escaping (DI_MailList) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.SEARCH_URL
        let parameter = ["searchKeyword" : keyword]
        ApiManager.shared.requestApi(url, parameter, DI_MailList.self, .get, isContainToken: true, true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    static func getLetterDetail(id: Int, success: @escaping (DI_Mail) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = "\(ConstGroup.MAIL_DETAIL_URL)/\(id)"
        ApiManager.shared.requestApi(url, nil, DI_Mail.self, .get, isContainToken: true, false, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    //MARK:- 북마크
    static func postAddBookMark(letterId: Int, success: @escaping () -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.BOOKMARK_URL
        let parameter = ["letterId" : letterId]
        ApiManager.shared.requestApiParamInt(url, parameter, DI_Common.self, .post, isContainToken: true, success: { _ in
            success()
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    static func deleteBookMark(bookmarkId: Int, success: @escaping () -> Void, failure: @escaping (Error?) -> Void ) {
        let url = "\(ConstGroup.BOOKMARK_URL)/\(bookmarkId)"
        ApiManager.shared.requestApi(url, nil, DI_Common.self, .delete, isContainToken: true, success: { _ in
            success()
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }

    static func getBookMarkList(id: Int, success: @escaping (DI_MailList) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = "\(ConstGroup.BOOKMARK_URL)?lastLetterId=\(id)"
        ApiManager.shared.requestApi(url, nil, DI_MailList.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 플랫폼
    static func getSubscribingPlatforms(success: @escaping (DI_PlatformList) -> Void, failure: @escaping (Error?) -> Void ) {
        let userId = MemberManager.shared.getuserId()
        let url = "\(ConstGroup.USERINFO_URL)/\(userId)/subscribing-platforms"
        ApiManager.shared.requestApi(url, nil, DI_PlatformList.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    static func getTotalPlatforms(success: @escaping (DI_PlatformList) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.TOTAL_PLATFORM_URL
        ApiManager.shared.requestApi(url, nil, DI_PlatformList.self, .get, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 마이페이지
    //프로필
    static func patchChangeNickname(nickname: String, success: @escaping (DI_UserInfo) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.NICKNAME_URL
        let parameter = ["nickname" : nickname]
        ApiManager.shared.requestApi(url, parameter, DI_UserInfo.self, .patch, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //플랫폼구독취소
    static func deletePlatform(id: Int, success: @escaping (DI_Platform) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = "\(ConstGroup.PLATFORM_URL)/\(id)"
        ApiManager.shared.requestApi(url, nil, DI_Platform.self, .delete, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //프로필 구독추가
    static func addPlatform(id: Int, success: @escaping (DI_Platform) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = "\(ConstGroup.PLATFORM_URL)/\(id)"
        ApiManager.shared.requestApi(url, nil, DI_Platform.self, .post, isContainToken: true, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
}
