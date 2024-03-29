//
//  NetworkConstants.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/11.
//

import Foundation
import Alamofire

/*
 NetworkConstants : 서버통신과정에서 필요한 상수들을 관리 -> header 관련 상수들
 */

enum HeaderType {
    case basic
    case authRenewal
    case auth
    case multiPart
    case multiPartWithAuth
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum ContentType: String {
    case json = "Application/json"
    case multiPart = "multipart/form-data"
}
