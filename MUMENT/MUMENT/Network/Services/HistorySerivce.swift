//
//  HistorySerivce.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Alamofire

enum HistorySerivce {
    case getMumentHistoryData(userId: String, musicId: String, recentOnTop:Bool)
}

extension HistorySerivce: TargetType {
    var path: String {
        switch self {
        case .getMumentHistoryData(userId: let userId, musicId: let musicId,_):
            return "/mument/\(userId)/\(musicId)/history"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMumentHistoryData:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getMumentHistoryData:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMumentHistoryData(_, _, recentOnTop: let recentOnTop):
            return .query(["default": recentOnTop ? "Y" : "N"])
        }
    }
}
