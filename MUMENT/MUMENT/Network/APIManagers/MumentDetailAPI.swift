//
//  MumentDetailAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//
import Foundation
import Alamofire

class MumentDetailAPI: BaseAPI {
    static let shared = MumentDetailAPI()
    
    private override init() { }
    
    /// [GET] 곡 정보, 내가 기록한 뮤멘트
    func getMumentDetail(mumentId: String, userId: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MumentDetailService.getMumentDetail(mumentId: mumentId, userId: userId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, MumentDetailResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

