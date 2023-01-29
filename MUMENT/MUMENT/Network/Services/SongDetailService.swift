//
//  SongDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//
///////
import Alamofire

enum SongDetailService {
    case getSongInfo(musicId: String)
    case getAllMuments(musicId: String, isOrderLiked: Bool, limit: Int, offset: Int)
}

extension SongDetailService: TargetType {
    
    var path: String {
        switch self {
        case .getSongInfo(musicId: let musicId):
            return "/music/\(musicId)"
        case .getAllMuments(musicId: let musicId, _, _, _):
            return "/music/\(musicId)/order"
        }
    }
    
    var method: HTTPMethod {
            return .get
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSongInfo:
            return .requestPlain
        case .getAllMuments(_, isOrderLiked: let isOrderLiked, limit: let limit, offset: let offset):
            return .query(["default": isOrderLiked ? "Y" : "N", "limit": limit, "offset": offset])
        }
    }
}
