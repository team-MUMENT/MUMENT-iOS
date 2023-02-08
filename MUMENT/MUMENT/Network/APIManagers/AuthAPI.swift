//
//  SignAPI.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation
import Alamofire

/*
 ~API: 실제 서버통신을 하기 위해 API를 구현하는 클래스 (BaseAPI를 상속)
 싱글턴으로 접근한다. 앞서 만든 request 함수를 호출하고 Service를 통해 서버통신 수행
 네트워크 결과를 받아와서 처리
 */

class AuthAPI: BaseAPI {
    static let shared = AuthAPI()
    
    private override init() { }
    
    /// [POST] 로그인
    func postSignIn(body: SignInBodyModel,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthService.postSignIn(body: body)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SignInResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 토큰 재발급
    func getRenewedToken(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthService.getRenewedToken).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, TokenRenewalResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                completion(.networkFail)
            }
        }
    }
    
    /// [GET] 프로필 설정 유무 확인
    func getIsProfileSet(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthService.getIsProfileSet).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                let networkResult = self.judgeStatus(by: statusCode)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [POST] 로그아웃 요청
    func requestSignOut(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthService.requestSignOut).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                let networkResult = self.judgeStatus(by: statusCode)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
