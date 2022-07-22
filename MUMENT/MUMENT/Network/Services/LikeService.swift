//
//  LikeService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//
import Alamofire

enum LikeSerivce {
    case postHeartLiked(mumentId: String, userId: String)
    case deleteHeartLiked(mumentId: String, userId: String)
}

extension LikeSerivce: TargetType {
    var path: String {
        switch self {
        case .postHeartLiked(mumentId: let mumentId, userId: let userId):
            return "/mument/\(mumentId)/\(userId)/like"
        case .deleteHeartLiked(mumentId: let mumentId, userId: let userId):
            return "/mument/\(mumentId)/\(userId)/like"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postHeartLiked:
            return .post
        case .deleteHeartLiked:
            return .delete
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postHeartLiked:
            return .basic
        case .deleteHeartLiked:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postHeartLiked:
            return .requestPlain
        case .deleteHeartLiked:
            return .requestPlain
        }
    }
}
