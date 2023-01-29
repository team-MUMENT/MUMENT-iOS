//
//  MyPageService.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Alamofire

enum MyPageService {
    case postWithdrawalReason(body: WithdrawalReasonBodyModel)
    case deleteMembership
}

extension MyPageService: TargetType {
    var path: String {
        switch self {
        case .postWithdrawalReason:
            return "/user/leave-category"
        case .deleteMembership:
            return "/user/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postWithdrawalReason:
            return .post
        case .deleteMembership:
            return .delete
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postWithdrawalReason:
            return .auth
        case .deleteMembership:
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postWithdrawalReason(let body):
            return .requestBody(["leaveCategoryId": body.leaveCategoryId, "reasonEtc": body.reasonEtc])
        case .deleteMembership:
            return .requestPlain
        }
    }
}
