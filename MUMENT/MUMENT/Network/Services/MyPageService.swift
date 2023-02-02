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
    case getBlockedUserList
    case deleteBlockedUser(userId: Int)
    case getNoticeList
    case getNoticeDetail(noticeId: Int)
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
        case .getBlockedUserList:
            return "/user/block"
        case .deleteBlockedUser(let userId):
            return "/user/block/\(userId)"
        case .getNoticeList:
            return "/mument/notice"
        case .getNoticeDetail(let noticeId):
            return "mument/notice/\(noticeId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postWithdrawalReason:
            return .post
        case .deleteMembership, .deleteBlockedUser:
            return .delete
        case.checkDuplicatedNickname, .getBlockedUserList, .getNoticeList, .getNoticeDetail:
            return .get
        case .setProfile:
            return .put
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postWithdrawalReason, .deleteMembership, .checkDuplicatedNickname, .getBlockedUserList, .deleteBlockedUser:
            return .auth
        case .setProfile:
            return .multiPartWithAuth
        case .getNoticeList, .getNoticeDetail:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postWithdrawalReason(let body):
            return .requestBody([
                "leaveCategoryId": body.leaveCategoryId,
                "reasonEtc": body.reasonEtc
            ])
        case .deleteMembership, .checkDuplicatedNickname, .getBlockedUserList, .setProfile, .deleteBlockedUser, .getNoticeList, .getNoticeDetail:
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
