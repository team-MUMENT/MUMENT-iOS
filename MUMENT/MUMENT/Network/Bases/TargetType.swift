//
//  TargetType.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/11.
//

import Foundation
import Alamofire

/*
 TargetType : URLRequestConvertible을 채택한 프로토콜, 실제 각 Endpont에 해당하는 Router들이
 TargetType를 채택하여 request 과정을 모듈화.
 */

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var header: HeaderType { get }
    var multipart: MultipartFormData { get }
}

extension TargetType {
    var baseURL: String {
        return APIConstants.baseURL
    }
    
    var multipart: MultipartFormData {
        return MultipartFormData()
    }
    
    // URLRequestConvertible 구현
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        urlRequest = self.makeHeaderForRequest(to: urlRequest)
        
        return try self.makeParameterForRequest(to: urlRequest, with: url)
    }
    
    private func makeHeaderForRequest(to request: URLRequest) -> URLRequest {
        var request = request
        
        switch header {
        case .basic:
            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
        case .authRenewal:
            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserDefaultsManager.refreshToken ?? UserInfo.shared.refreshToken, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
            
        case .auth:
            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserDefaultsManager.accessToken ?? UserInfo.shared.accessToken, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
            
        case .multiPart:
            request.setValue(ContentType.multiPart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
        case .multiPartWithAuth:
            request.setValue(ContentType.multiPart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserDefaultsManager.accessToken ?? UserInfo.shared.accessToken, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        return request
    }
    
    private func makeParameterForRequest(to request: URLRequest, with url: URL) throws -> URLRequest {
        var request = request
        
        switch parameters {
        case .query(let query):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
        case .queryBody(let query, let body):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
        case .requestBody(let body):
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
            /// get 통신에서 사용
        case .requestPlain:
            break
        }
        
        return request
    }
}

enum RequestParams {
    case query(_ query: [String : Any])
    case queryBody(_ query: [String : Any], _ body: [String : Any])
    case requestBody(_ body: [String : Any])
    case requestPlain
}
