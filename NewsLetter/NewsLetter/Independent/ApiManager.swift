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
    
    func requestApi<T: Decodable>(_ url: String, _ param: [String: String]?, _ type: T.Type, _ method: HTTPMethod, isContainToken: Bool = false, _ isQueryEncoding: Bool = false,  success: @escaping (T)-> Void, failure: @escaping (FailureResult, Any) -> Void) {
        guard checkNetworkAvailable() == true else { failure(.network, ""); return }
        var headerData: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
        if isContainToken {
            if let token = KeychainService.shared.loadToken() {
                headerData.add(name: "x-access-token", value: token)
            }
            else {
                failure(.custom, "Error")
            }
        }
        
        var encoder: ParameterEncoder = JSONParameterEncoder.default
        if isQueryEncoding {
            encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        }
        
        AF.request(url, method: method, parameters: param, encoder: encoder, headers: headerData).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    print(err.localizedDescription)
                    failure(.custom, "Parsing Error")
                }
            case .failure(let err):
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let posts = json?["message"] ?? "Error"
                        failure(.custom, posts)
                    }
                    catch {
                        failure(.custom, "Parsing Error" )
                    }
                }
                else {
                    failure(.custom, err.localizedDescription)
                }
            }
        }
    }
    
    func requestApiParamInt<T: Decodable>(_ url: String, _ intParam: [String: Int]?, _ type: T.Type, _ method: HTTPMethod, isContainToken: Bool = false, success: @escaping (T)-> Void, failure: @escaping (FailureResult, Any) -> Void) {
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
        
        AF.request(url, method: method, parameters: intParam, encoder: JSONParameterEncoder.default, headers: headerData).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    print(err.localizedDescription)
                    failure(.custom, "Parsing Error")
                }
            case .failure(let err):
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let posts = json?["message"] ?? "Error"
                        failure(.custom, posts)
                    }
                    catch {
                        failure(.custom, "Parsing Error" )
                    }
                }
                else {
                    failure(.custom, err.localizedDescription)
                }
            }
        }
    }
    
    
    
    func requestApiClassParam<T: Decodable, U: Codable>(_ url: String, _ classParam: Any?, _ type: T.Type, _ paramType: U.Type, _ method: HTTPMethod, isContainToken: Bool = false, success: @escaping (T)-> Void, failure: @escaping (FailureResult, Any) -> Void) {
        guard checkNetworkAvailable() == true else { failure(.network, ""); return }
        guard let classParam = classParam as? U else { failure(.custom, "Error"); return }
        var headerData: HTTPHeaders = [ "Content-Type": "application/json" ]
        if isContainToken {
            if let token = KeychainService.shared.loadToken() {
                headerData.add(name: "x-access-token", value: token)
            }
            else {
                failure(.custom, "Error")
            }
        }
        AF.request(url, method: method, parameters: classParam, encoder: customEncoder(encoder: URLEncodedFormEncoder()), headers: headerData).validate().responseJSON { response in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(type, from: jsonData)
                    success(json)
                }
                catch(let err) {
                    print(err.localizedDescription)
                    failure(.custom, "Parsing Error")
                }
            case .failure(let err):
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let posts = json?["message"] ?? "Error"
                        failure(.custom, posts)
                    }
                    catch {
                        failure(.custom, "Parsing Error" )
                    }
                }
                else {
                    failure(.custom, err.localizedDescription)
                }
            }
        }
    }
    
    func requestHtml(_ url: String, _ method: HTTPMethod, isContainToken: Bool = false, success: @escaping (String)-> Void, failure: @escaping (FailureResult, Any) -> Void) {
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
        
        AF.request(url, method: method, headers: headerData).validate().responseString { response in
            switch response.result {
            case .success(let res):
                if let data = response.data {
                    success(String(decoding: data, as: UTF8.self))
                }
                else {
                    failure(.custom, "No Html" )
                }
            case .failure(let err):
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                        let posts = json?["message"] ?? "Error"
                        failure(.custom, posts)
                    }
                    catch {
                        failure(.custom, "Parsing Error" )
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

//struct ArrayEncoding: ParameterEncoder {
//    func encode<Parameters>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest where Parameters : Encodable {
//        var request = try URLEncoding().encode(urlRequest, with: parameters)
//        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
//        return request
//    }
    
//    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var request = try URLEncoding().encode(urlRequest, with: parameters)
//        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
//        return request
//    }
//}

struct customEncoder: ParameterEncoder {
    public let encoder: URLEncodedFormEncoder

    func encode<Parameters>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest where Parameters : Encodable {
        guard let parameters = parameters else { return request }
        var request = request

        guard let url = request.url else {
            throw AFError.parameterEncoderFailed(reason: .missingRequiredComponent(.url))
        }
        
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let query: String = try Result<String, Error> { try encoder.encode(parameters) }
                .mapError { AFError.parameterEncoderFailed(reason: .encoderFailed(error: $0)) }.get()
            var newQueryString = [components.percentEncodedQuery, query].compactMap { $0 }.joinedWithAmpersands()
            newQueryString = newQueryString.replacingOccurrences(of: "%5B%5D=", with: "=")
            components.percentEncodedQuery = newQueryString.isEmpty ? nil : newQueryString
            guard let newURL = components.url else {
                throw AFError.parameterEncoderFailed(reason: .missingRequiredComponent(.url))
            }

            request.url = newURL
        } else {
            if request.headers["Content-Type"] == nil {
                request.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
            }

            request.httpBody = try Result<Data, Error> { try encoder.encode(parameters) }
                .mapError { AFError.parameterEncoderFailed(reason: .encoderFailed(error: $0)) }.get()
        }

        
        return request
    }
}

extension Array where Element == String {
    func joinedWithAmpersands() -> String {
        joined(separator: "&")
    }
}
