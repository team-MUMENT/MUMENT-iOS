//
//  SongDetailAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//
//////
import Foundation
import Alamofire

class SongDetailAPI: BaseAPI {
    static let shared = SongDetailAPI()
    
    private override init() { }
    
    /// [GET] 곡 정보, 내가 기록한 뮤멘트
    func getSongInfo(musicData: MusicDTO,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SongDetailService.getSongInfo(musicData: musicData)).responseData { response in
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
    
    /// [GET] 모든 뮤멘트
    func getAllMuments(musicId: String, isOrderLiked: Bool,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SongDetailService.getAllMuments(musicId: musicId, isOrderLiked: isOrderLiked)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 204 {
                    let result: AllMumentsResponseModel = AllMumentsResponseModel(mumentList: [])
                    completion(.success(result))
                } else {
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode, data, AllMumentsResponseModel.self)
                    completion(networkResult)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
