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

enum ContentResult<T> {
    case success(T)
    case failure(Error)
}


class ApiManager {
    static let shared = ApiManager()
    private init() {} //생성자를 private하게 정의. 외부에서 인스턴스 생성x. 싱글톤 인스턴스를 하나만!
    
    //헤더는 이후 필요하면 추가하기!
    //validate는 status code가 200대인지와 header와 일치하는 content type인지를 검사한다.

    func getApi<T: Decodable>(_ url: String, _ type: T.Type, success: @escaping (T)-> Void, failure: @escaping (String) -> Void) {
        guard checkNetworkAvailable() == true else { failure("네트워크 에러입니다."); return }
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    failure("\(err.localizedDescription) _ get catch부분")
                }
            case .failure(let err):
                failure("\(err.localizedDescription) _ get failure부분")
            }
        }
    }
    
    func postApi<T: Decodable>(_ url: String, _ param: [String:String]?, _ type: T.Type, success: @escaping (T)-> Void, failure: @escaping (String) -> Void) {
        guard checkNetworkAvailable() == true else { failure("네트워크 에러입니다."); return }
        AF.request(url, method: .post, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    failure("\(err.localizedDescription) _ post catch부분")
                }
            case .failure(let err):
                failure("\(err.localizedDescription) _ post failure부분")
            }
        }
    }
    
    func deleteApi<T: Decodable>(_ url: String, _ type: T.Type, success: @escaping (T)-> Void, failure: @escaping (String) -> Void) {
        guard checkNetworkAvailable() == true else { failure("네트워크 에러입니다."); return }
        AF.request(url, method: .delete).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    failure("\(err.localizedDescription) _ delete catch부분")
                }
            case .failure(let err):
                failure("\(err.localizedDescription) _ delete failure부분")
            }
        }
    }
    
    
    func patchApi<T: Decodable>(_ url: String, _ param: [String:String]?, _ type: T.Type, success: @escaping (T)-> Void, failure: @escaping (String) -> Void) {
        guard checkNetworkAvailable() == true else { failure("네트워크 에러입니다."); return }
        AF.request(url, method: .patch, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    failure("\(err.localizedDescription) _ patch catch부분")
                }
            case .failure(let err):
                failure("\(err.localizedDescription) _ patch failure부분")
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
