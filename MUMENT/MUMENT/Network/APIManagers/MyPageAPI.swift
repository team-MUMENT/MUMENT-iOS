//
//  MyPageAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Foundation
import Alamofire

class MyPageAPI: BaseAPI {
    static let shared = MyPageAPI()
    
    private override init() { }
    
    /// [POST] 탈퇴 사유 등록
    func postWithdrawalReason(body: WithdrawalReasonBodyModel,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.postWithdrawalReason(body: body)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, WithdrawalReasonResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [DELETE] 회원 탈퇴
    func deleteMembership(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.deleteMembership).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, WithdrawalResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 닉네임 중복 체크
    func checkDuplicatedNickname(nickname: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.checkDuplicatedNickname(nickname: nickname)).responseData { response in
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
