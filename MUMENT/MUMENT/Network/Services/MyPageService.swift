//
//  MyPageService.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Alamofire
import UIKit

enum MyPageService {
    case postWithdrawalReason(body: WithdrawalReasonBodyModel)
    case deleteMembership
    case checkDuplicatedNickname(nickname: String)
    case setProfile(data: SetProfileRequestModel)
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
        case .setProfile:
            return "/user/profile"
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
        case .setProfile:
            return .put
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postWithdrawalReason, .deleteMembership, .checkDuplicatedNickname:
            return .auth
        case .setProfile:
            return .multiPartWithAuth
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
        case .setProfile:
            return .requestPlain
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .setProfile(let data):
            let multiPartFormData = MultipartFormData()
            multiPartFormData.append(data.image, withName: "image", fileName: "profileImageiOS.png")
            multiPartFormData.append(data.nickname.data(using: .utf8) ?? Data(), withName: "profileId")
            
            return multiPartFormData
        default:
            return MultipartFormData()
        }
    }
}
