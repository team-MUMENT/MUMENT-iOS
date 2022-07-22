//
//  MumentDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Alamofire

enum MumentDetailService {
    case getMumentDetail(mumentId: String, userId: String)
}

extension MumentDetailService: TargetType {
    var path: String {
        switch self {
        case .getMumentDetail(mumentId: let mumentId, userId: let userId):
            return "/mument/\(mumentId)/\(userId)"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMumentDetail:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getMumentDetail:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMumentDetail:
            return .requestPlain
        }
    }
}
