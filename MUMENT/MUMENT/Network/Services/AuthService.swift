//
//  zzService.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/11.
//

import Alamofire

/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 TargetType을 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */

enum AuthService {
    case postSignIn(body: SignInBodyModel)
    case getRenewedToken
    case getIsProfileSet
    case requestSignOut
    case requestAdminSignIn(userID: Int, userName: String)
}

extension AuthService: TargetType {
    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/login"
        case .getRenewedToken:
            return "/auth/token"
        case .getIsProfileSet:
            return "/user/profile/check"
        case .requestSignOut:
            return "/auth/logout"
        case .requestAdminSignIn:
            return "/auth/admin/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignIn, .requestSignOut, .requestAdminSignIn:
            return .post
        case .getRenewedToken:
            return .get
        case .getIsProfileSet:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postSignIn, .requestAdminSignIn:
            return .basic
        case .getRenewedToken:
            return .authRenewal
        case .getIsProfileSet, .requestSignOut:
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postSignIn(let body):
            return .requestBody(["provider": body.provider, "authentication_code": body.authentication_code, "fcm_token": body.fcm_token])
            
        case .requestAdminSignIn(let userID, let userName):
            return .requestBody([
                "id": userID,
                "userName": userName,
                "provider": "admin"
            ])
            
        case .getRenewedToken, .getIsProfileSet, .requestSignOut:
            return .requestPlain
        }
    }
}
