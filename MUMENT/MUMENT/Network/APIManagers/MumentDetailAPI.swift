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
    
    /// [GET] 뮤멘트 상세보기
    func getMumentDetail(
        mumentId: Int,
        completion: @escaping (NetworkResult<Any>
        ) -> (Void)) {
        AFmanager.request(MumentDetailService.getMumentDetail(mumentId: mumentId)).responseData { response in
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
    
    /// [POST] 뮤멘트 신고하기
    func postReportMument(
        mumentId: Int, reportCategory: [Int], content: String,
        completion: @escaping (NetworkResult<Any>
        ) -> (Void)) {
        AFmanager.request(MumentDetailService.postReportMument(mumentId: mumentId, reportCategory: reportCategory, content: content)).responseData { response in
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
    
    /// [POST] 뮤멘트 신고하기
    func postUserBlock(
        mumentId: Int,
        completion: @escaping (NetworkResult<Any>
        ) -> (Void)) {
        AFmanager.request(MumentDetailService.postUserBlock(mumentId: mumentId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, UserBlockResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

