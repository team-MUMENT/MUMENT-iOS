//
//  SongDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Alamofire

/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 TargetType을 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */

//// MARK: - SongDetailBodyModel
//struct SongDetailBodyModel: Codable {
//    var musicId: String
//    var userId: String
//}

enum SongDetailService {
    case getSongInfo(musicId: String, userId: String)
    case getAllMuments(musicId: String, userId: String, isOrderLiked: Bool)
}

extension SongDetailService: TargetType {
    var path: String {
        switch self {
        case .getSongInfo(musicId: let musicId, userId: let userId):
            return "/\(musicId)/\(userId)"
        case .getAllMuments(musicId: let musicId, userId: let userId, _):
            return "/\(musicId)/\(userId)/order"
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
            return .basic
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
