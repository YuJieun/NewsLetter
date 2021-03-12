//
//  ApiManager.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/07.
//

import Foundation
import Alamofire
import Network
import Reachability

enum FailureResult {
    case network
    case custom
}

class DI_Error: Codable {
    var code: String = ""
    var message: String = ""
}

class ApiManager {
    
    static let shared = ApiManager()
    private init() {} //생성자를 private하게 정의. 외부에서 인스턴스 생성x. 싱글톤 인스턴스를 하나만!
    
    //헤더는 이후 필요하면 추가하기!
    //validate는 status code가 200대인지와 header와 일치하는 content type인지를 검사한다.
    
    func requestApi<T: Decodable>(_ url: String, _ param: [String: String]?, _ type: T.Type, _ method: HTTPMethod, isContainToken: Bool = false, success: @escaping (T)-> Void, failure: @escaping (FailureResult, Any) -> Void) {
        guard checkNetworkAvailable() == true else { failure(.network, ""); return }
        var headerData: HTTPHeaders = [ "Content-Type": "application/json" ]
        if isContainToken {
            if let token = KeychainService.shared.loadToken() {
                headerData.add(name: "x-access-token", value: token)
            }
            else {
                failure(.custom, "Error")
            }
        }
        AF.request(url, method: method, parameters: param, encoder: JSONParameterEncoder.default, headers: headerData).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    failure(.custom, err.localizedDescription)
                }
            case .failure(let err):
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let posts = json?["message"] ?? "Error"
                        failure(.custom, posts)
                    }
                    catch(let err) {
                        failure(.custom, err.localizedDescription )
                    }
                }
                else {
                    failure(.custom, err.localizedDescription)
                }
            }
        }
    }
       
    func checkNetworkAvailable() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi, .cellular :
            return true
        default:
            return false
        }
    }
}
