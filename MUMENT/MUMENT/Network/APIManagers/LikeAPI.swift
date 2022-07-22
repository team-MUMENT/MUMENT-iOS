//
//  LikeAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//
import Foundation
import Alamofire

class LikeAPI: BaseAPI {
    static let shared = LikeAPI()
    
    private override init() { }
    
    /// [POST] 뮤멘트 좋아요
    func postHeartLiked(mumentId: String, userId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {

        AFmanager.request(LikeSerivce.postHeartLiked(mumentId: mumentId, userId: userId)).responseData { response in
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
    
    /// [DELETE] 뮤멘트 좋아요 취소
    func deleteHeartLiked(mumentId: String, userId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(LikeSerivce.deleteHeartLiked(mumentId: mumentId, userId: userId)).responseData { response in
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
