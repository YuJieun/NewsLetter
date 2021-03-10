//
//  DataRequest.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/06.
//

import Foundation
import Alamofire

class DI_Weather: Codable {
    var timezone: Int?
    var visibility: Int?
    var haha: Int?
}

class DataRequest {
    static func handleErrorType(_ errType: FailureResult, _ data: Error?, _ closure: (Error?) -> Void) {
        switch errType {
        case .alert :
            let alert: UIAlertController = UIAlertController(title: "알림", message: "네트워크에 연결할 수 없습니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in }
            alert.addAction(okAction)
            alert.show()
        case .custom :
            closure(data)
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
    
    //MARK:- 북마크
    static func getBookMark(success: @escaping (DI_BookMarkList) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.BOOKMARK_LIST_URL
        ApiManager.shared.getApi(url, DI_BookMarkList.self, success: { (data) in
            success(data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
    
    static func getWeatherApI(success: @escaping (Bool, DI_Weather) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.WEATHER_URL
        ApiManager.shared.getApi(url, DI_Weather.self, success: { (data) in
            success(false, data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
}
