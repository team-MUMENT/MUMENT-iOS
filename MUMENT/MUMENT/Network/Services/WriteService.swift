//
//  WriteService.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation
import Alamofire

enum WriteService {
    case getIsFirst(userId: String, musicId: String)
}

extension WriteService: TargetType {
    var path: String {
        switch self {
        case .getIsFirst(let userId, let musicId):
            return "/mument/\(userId)/\(musicId)/is-first"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getIsFirst:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getIsFirst:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getIsFirst:
            return .requestPlain
        }
    }
}
