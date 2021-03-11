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
        ApiManager.shared.postApi(url, parameter, DI_User.self, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 로그인
    static func postLogin(param: DIR_User, success: @escaping (DI_User) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.LOGIN_URL
        let parameter = param.dictionary
        ApiManager.shared.postApi(url, parameter, DI_User.self, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    //MARK:- 북마크
//    static func getBookMark(success: @escaping (DI_BookMarkList) -> Void, failure: @escaping (Error?) -> Void ) {
//        let url = ConstGroup.BOOKMARK_LIST_URL
//        ApiManager.shared.getApi(url, DI_BookMarkList.self, success: { (data) in
//            success(data)
//        }, failure: { (errType, data) in
//            handleErrorType(errType, data, failure)
//        })
//    }
    
}
