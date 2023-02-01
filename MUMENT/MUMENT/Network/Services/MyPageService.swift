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
    case checkDuplicatedNickname(nickname: String)
}

extension MyPageService: TargetType {
    var path: String {
        switch self {
        case .postWithdrawalReason:
            return "/user/leave-category"
        case .deleteMembership:
            return "/user/"
        case .checkDuplicatedNickname(let nickname):
            return "/user/profile/check/\(nickname)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postWithdrawalReason:
            return .post
        case .deleteMembership:
            return .delete
        case.checkDuplicatedNickname:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postWithdrawalReason, .deleteMembership, .checkDuplicatedNickname:
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postWithdrawalReason(let body):
            return .requestBody([
                "leaveCategoryId": body.leaveCategoryId,
                "reasonEtc": body.reasonEtc
            ])
        case .deleteMembership, .checkDuplicatedNickname:
            return .requestPlain
        }
    }
}
