//
//  DeleteService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//

import Alamofire

enum DeleteSerivce {
    case deleteMument(mumentId: String)
}

extension DeleteSerivce: TargetType {
    var path: String {
        switch self {
        case .deleteMument(mumentId: let mumentId):
            return "/mument/\(mumentId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .deleteMument:
            return .delete
        }
    }
    
    var header: HeaderType {
        switch self {
        case .deleteMument:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .deleteMument:
            return .requestPlain
        }
    }
}
