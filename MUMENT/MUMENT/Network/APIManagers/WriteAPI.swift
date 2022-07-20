//
//  WriteAPI.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation
import Alamofire

class WriteAPI: BaseAPI {
    static let shared = WriteAPI()
    
    private override init() { }
    
    /// [GET] 처음/다시 조회
    func getIsFirst(userId: String, musicId: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.getIsFirst(userId: userId, musicId: musicId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetIsFirstResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
