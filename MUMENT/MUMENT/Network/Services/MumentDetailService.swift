//
//  MumentDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Alamofire

enum MumentDetailService {
    case getMumentDetail(mumentId: Int)
}

extension MumentDetailService: TargetType {
    var path: String {
        switch self {
        case .getMumentDetail(mumentId: let mumentId):
            return "/mument/\(mumentId)"
        
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
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMumentDetail:
            return .requestPlain
        }
    }
}
