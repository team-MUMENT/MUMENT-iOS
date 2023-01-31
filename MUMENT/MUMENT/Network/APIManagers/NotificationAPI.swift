//
//  NotificationAPI.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/29.
//

import Foundation
import Alamofire

class NotificationAPI: BaseAPI {
    static let shared = NotificationAPI()
    
    private override init() { }
    
    /// [GET] 소식창 리스트 조회
    func getNotificationList(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(NotificationService.getNotificationList).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetNotificationListResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [PATCH] 알림 삭제
    func deleteNotifiction(id: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(NotificationService.deleteNotification(newsId: id)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [PATCH] 새로운 알림 읽음 처리
    func readNotification(idList: [Int], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(NotificationService.readNotification(newsIdList: idList)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
