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
    case getAllMuments(musicId: String, userId: String, isOrderLiked: Bool)
}

extension SongDetailService: TargetType {
    var path: String {
        switch self {
        case .getSongInfo(musicId: let musicId):
            return "/music/\(musicId)"
        case .getAllMuments(musicId: let musicId, userId: let userId, _):
            return "/music/\(musicId)/\(userId)/order"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSongInfo:
            return .get
        case .getAllMuments:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getSongInfo:
            return .auth
        case .getAllMuments:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSongInfo:
            return .requestPlain
        case .getAllMuments(_, _, isOrderLiked: let isOrderLiked):
            return .query(["default": isOrderLiked ? "Y" : "N"])
        }
    }
}
