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
    func postHeartLiked(mumentId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {

        AFmanager.request(LikeSerivce.postHeartLiked(mumentId: mumentId)).responseData { response in
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
    func deleteHeartLiked(mumentId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(LikeSerivce.deleteHeartLiked(mumentId: mumentId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, LikeCancelResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 뮤멘트 좋아요한 이용자 리스트
    func getLikedUsetList(mumentId: Int, limit: Int, offset: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(LikeSerivce.getLikedUsetList(mumentId: mumentId, limit: limit, offset: offset)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, [LikedUserListResponseModel].self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
