//
//  MumentDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Alamofire

enum MumentDetailService {
    case getMumentDetail(mumentId: Int)
    case postReportMument(mumentId: Int, reportCategory: [Int], content: String)
}

extension MumentDetailService: TargetType {
    var path: String {
        switch self {
        case .getMumentDetail(mumentId: let mumentId):
            return "/mument/\(mumentId)"
        case .postReportMument(mumentId: let mumentId, _, _):
            return "/mument/report/\(mumentId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMumentDetail:
            return .get
        case .postReportMument:
            return .post
        }
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMumentDetail:
            return .requestPlain
        case .postReportMument(_, let reportCategory, let content):
            return .requestBody([
                "reportCategory": reportCategory,
                "etcContent": content
            ])
        }
    }
}
