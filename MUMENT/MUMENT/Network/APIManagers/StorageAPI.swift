//
//  StorageAPI.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/21.
//

import Foundation
import Alamofire

class StorageAPI: BaseAPI {
    static let shared = StorageAPI()
    
    private override init() { }
    
    /// [GET] 내가 작성한 뮤멘트 리스트 with 필터
    func getMyMumentStorage(filterTags: [Int], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(StorageService.getMyMumentStorage(filterTags: filterTags)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetMyMumentResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 좋아요한 뮤멘트 리스트 with 필터
    func getLikedMumentStorage(filterTags: [Int], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(StorageService.getLikedMumentStorage(filterTags: filterTags)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetLikedMumentResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
    //  /// [GET] 처음/다시 조회
    //  func getIsFirst(userId: String, musicId: String,
    //          completion: @escaping (NetworkResult<Any>) -> (Void)) {
    //    AFmanager.request(WriteService.getIsFirst(userId: userId, musicId: musicId)).responseData { response in
    //      switch response.result {
    //      case .success:
    //        guard let statusCode = response.response?.statusCode else { return }
    //        guard let data = response.data else { return }
    //        let networkResult = self.judgeStatus(by: statusCode, data, GetIsFirstResponseModel.self)
    //        completion(networkResult)
    //      case .failure(let err):
    //        print(err.localizedDescription)
    //      }
    //    }
    //  }
}
