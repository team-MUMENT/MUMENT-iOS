//
//  LikeService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//
import Alamofire

enum LikeSerivce {
    case postHeartLiked(mumentId: Int)
    case deleteHeartLiked(mumentId: Int)
}

extension LikeSerivce: TargetType {
    var path: String {
        switch self {
        case .postHeartLiked(mumentId: let mumentId):
            return "/mument/\(mumentId)/like"
        case .deleteHeartLiked(mumentId: let mumentId):
            return "/mument/\(mumentId)/like"
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
        return .auth
    }
    
    var parameters: RequestParams {
        return .requestPlain
    }
}
