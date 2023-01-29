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
    func getIsFirst(musicId: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.getIsFirst(musicId: musicId)).responseData { response in
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
    
    /// [POST] 뮤멘트 기록하기
    func postMument(musicId: String, data: PostMumentBodyModel,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.postMument(musicId: musicId, data: data)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, PostMumentResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
