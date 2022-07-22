//
//  DeleteAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//
import Foundation
import Alamofire

class DeleteAPI: BaseAPI {
    static let shared = DeleteAPI()
    
    private override init() { }
    
    /// [GET] 검색 결과 조회
    func deleteMument(mumentId: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(DeleteSerivce.deleteMument(mumentId: mumentId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, LikeResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
