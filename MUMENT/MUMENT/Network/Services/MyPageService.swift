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
    case postWithdrawal(socialToken: String)
    case checkDuplicatedNickname(nickname: String)
    case setProfile(data: SetProfileRequestModel)
    case getBlockedUserList
    case deleteBlockedUser(userId: Int)
    case getNoticeList
    case getNoticeDetail(noticeId: Int)
    case getMypageURL(isFromSignIn: Bool = false)
    case getUserProfile
    case getAppVersion
}

extension MyPageService: TargetType {
    var path: String {
        switch self {
        case .postWithdrawalReason:
            return "/user/leave-category"
        case .postWithdrawal:
            return "/user/leave"
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
            return "/mument/notice/\(noticeId)"
        case .getMypageURL, .getAppVersion:
            return "/user/webview-link"
        case .getUserProfile:
            return "/user/profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postWithdrawalReason, .postWithdrawal:
            return .post
        case .deleteBlockedUser:
            return .delete
        case.checkDuplicatedNickname, .getBlockedUserList, .getNoticeList, .getNoticeDetail, .getMypageURL, .getUserProfile, .getAppVersion:
            return .get
        case .setProfile:
            return .put
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postWithdrawalReason, .postWithdrawal, .checkDuplicatedNickname, .getBlockedUserList, .deleteBlockedUser, .getUserProfile:
            return .auth
        case .setProfile:
            return .multiPartWithAuth
        case .getNoticeList, .getNoticeDetail, .getMypageURL, .getAppVersion:
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
        case .postWithdrawal(let socialToken):
            return .requestBody([
                "socialToken": socialToken
            ])
        case .checkDuplicatedNickname, .getBlockedUserList, .setProfile, .deleteBlockedUser, .getNoticeList, .getNoticeDetail, .getUserProfile:
            return .requestPlain
        case .getMypageURL(let isFromSignIn):
            return .query(["page": isFromSignIn ? "login" : "mypage"])
        case .getAppVersion:
            return .query(["page": "version"])
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .setProfile(let data):
            let multiPartFormData = MultipartFormData()
            multiPartFormData.append(data.image, withName: "image", fileName: "profileImageiOS.png")
            multiPartFormData.append(data.nickname.data(using: .utf8) ?? Data(), withName: "userName")
            
            return multiPartFormData
        default:
            return MultipartFormData()
        }
    }
}
