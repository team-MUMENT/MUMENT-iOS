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
    case getLikedUsetList(mumentId: Int, limit: Int, offset: Int)
}

extension LikeSerivce: TargetType {
    var path: String {
        switch self {
        case .postHeartLiked(mumentId: let mumentId):
            return "/mument/\(mumentId)/like"
        case .deleteHeartLiked(mumentId: let mumentId):
            return "/mument/\(mumentId)/like"
        case .getLikedUsetList(mumentId: let mumentId, _, _):
            return "/mument/\(mumentId)/like"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postHeartLiked:
            return .post
        case .deleteHeartLiked:
            return .delete
        case .getLikedUsetList:
            return .get
        }
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .postHeartLiked, .deleteHeartLiked:
            return .requestPlain
        case .getLikedUsetList(_, limit: let limit, offset: let offset):
            return .query(["limit": limit, "offset": offset])
        }
    }
}
