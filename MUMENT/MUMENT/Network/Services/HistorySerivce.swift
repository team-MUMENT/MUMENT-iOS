//
//  HistorySerivce.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Alamofire

enum HistorySerivce {
    case getMumentHistoryData(userId: Int, musicId: String, recentOnTop:Bool, limit: Int, offset: Int)
}

extension HistorySerivce: TargetType {
    var path: String {
        switch self {
        case .getMumentHistoryData(userId: let userId, musicId: let musicId, _, _, _):
            return "/mument/\(musicId)/\(userId)/history"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMumentHistoryData:
            return .get
        }
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMumentHistoryData(_, _, recentOnTop: let recentOnTop, limit: let limit, offset: let offset):
            return .query(["default": recentOnTop ? "Y" : "N", "limit": "\(limit)", "offset": "\(offset)"])
        }
    }
}
