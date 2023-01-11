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
}

extension AuthService: TargetType {
    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignIn:
            return .post
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postSignIn:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postSignIn(let body):
            return .requestBody(["provider": body.provider, "authentication_code": body.authentication_code])
        }
    }
}
