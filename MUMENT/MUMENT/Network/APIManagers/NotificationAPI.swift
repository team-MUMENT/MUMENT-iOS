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
}
