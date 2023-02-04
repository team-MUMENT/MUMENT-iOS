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
                let networkResult = self.judgeStatus(by: statusCode, data, CarouselResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 오늘의 뮤멘트
    func getMumentForTodayData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentForTodayData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, MumentForTodayResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 다시 들은 곡의 뮤멘트
    func getMumentOfRevisitedData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentsOfRevisitedData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, MumentsOfRevisitedResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 랜덤 태그, 랜덤 뮤멘트
    func getMumentsByTagData(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getMumentsByTagData).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, MumentsByTagResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 유저 제재 알럿 유무 조회
    func getUserPenalty(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(HomeService.getUserPenalty).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetUserPenaltyResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
