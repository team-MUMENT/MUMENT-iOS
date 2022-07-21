//
//  HomeAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Foundation
import Alamofire

class HomeAPI: BaseAPI {
    static let shared = HomeAPI()
    
    private override init() { }
    
    /// [GET] Carousel
    func getCarouselData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getCarouselData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SongInfoResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 오늘의 뮤멘트
    func getMumentForTodayData(userId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentForTodayData(userId: userId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, AllMumentsResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 다시 들은 곡의 뮤멘트
    func getMumentOfRevisitedData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentOfRevisitedData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, AllMumentsResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 랜덤 태그, 랜덤 뮤멘트
    func getMumentByTagData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentByTagData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, AllMumentsResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
