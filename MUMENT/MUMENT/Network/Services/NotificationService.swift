//
//  NotificationService.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/29.
//

import Foundation
import Alamofire

enum NotificationService {
    case getNotificationList
    case deleteNotification(newsId: Int)
}

extension NotificationService: TargetType {
    var path: String {
        switch self {
        case .getNotificationList:
            return "/user/news"
        case .deleteNotification(let newsId):
            return "/user/news/\(newsId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNotificationList:
            return .get
        case .deleteNotification:
            return .patch
        }
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .getNotificationList, .deleteNotification:
            return .requestPlain
        }
    }
}
