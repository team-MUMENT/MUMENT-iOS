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
    case postMument(userId: String, musicId: String, data: PostMumentBodyModel)
}

extension WriteService: TargetType {
    var path: String {
        switch self {
        case .getIsFirst(let userId, let musicId):
            return "/mument/\(userId)/\(musicId)/is-first"
        case .postMument(let userId, let musicId, _):
            return "/mument/\(userId)/\(musicId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getIsFirst:
            return .get
        case .postMument:
            return .post
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getIsFirst, .postMument:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getIsFirst:
            return .requestPlain
        case .postMument(_, _, let data):
            return .requestBody(["isFirst": data.isFirst, "impressionTag": data.impressionTag, "feelingTag": data.feelingTag, "content": data.content, "isPrivate": data.isPrivate])
        }
    }
}
