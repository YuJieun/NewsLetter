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
    
    static func getWeatherApI(success: @escaping (Bool, DI_Weather) -> Void, failure: @escaping (Error?) -> Void ) {
        let url = ConstGroup.WEATHER_URL
        ApiManager.shared.getApi(url, DI_Weather.self, success: { (data) in
            success(false, data)
        }, failure: { (errType, data) in
            handleErrorType(errType, data, failure)
        })
    }
}
