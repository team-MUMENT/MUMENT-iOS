//
//  HistoryAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Foundation
import Alamofire

class HistoryAPI: BaseAPI {
    static let shared = HistoryAPI()
    
    private override init() { }
    
    /// [GET] 뮤멘트 히스토리
    func getMumentHistoryData(userId: Int, musicId: String, recentOnTop:Bool, limit: Int, offset: Int,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        print("유저아이디", userId)
        print("뮤직아이디", musicId)
        AFmanager.request(HistorySerivce.getMumentHistoryData(userId: userId, musicId: musicId, recentOnTop: recentOnTop, limit: limit, offset: offset)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, HistoryResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
