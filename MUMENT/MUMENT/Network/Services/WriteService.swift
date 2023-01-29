//
//  WriteService.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation
import Alamofire

enum WriteService {
    case getIsFirst(musicId: String)
    case postMument(musicId: String, data: PostMumentBodyModel)
}

extension WriteService: TargetType {
    var path: String {
        switch self {
        case .getIsFirst(let musicId):
            return "/mument/\(musicId)/is-first"
        case .postMument(let musicId, _):
            return "/mument/\(musicId)"
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
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getIsFirst:
            return .requestPlain
        case .postMument(_, let data):
            return .requestBody([
                    "isFirst": data.isFirst,
                    "impressionTag": data.impressionTag,
                    "feelingTag": data.feelingTag,
                    "content": data.content,
                    "isPrivate": data.isPrivate,
                    "musicId": data.musicId,
                    "musicArtist": data.musicArtist,
                    "musicImage": data.musicImage,
                    "musicName": data.musicName
            ])
        }
    }
}
