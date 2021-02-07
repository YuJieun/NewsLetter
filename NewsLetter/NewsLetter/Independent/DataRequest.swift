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
    static func getWeatherApI(success: @escaping (Bool, DI_Weather) -> Void, failure: @escaping (_ str: String) -> Void ) {
        let url = ConstGroup.WEATHER_URL
        ApiManager.shared.getApi(url, DI_Weather.self, success: { (data) in
            success(false, data)
        }, failure: { errStr in
            failure(errStr)
        })
    }
}
