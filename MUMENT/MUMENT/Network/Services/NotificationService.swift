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
    case readNotification(newsIdList: [Int])
}

extension NotificationService: TargetType {
    var path: String {
        switch self {
        case .getNotificationList:
            return "/user/news"
        case .deleteNotification(let newsId):
            return "/user/news/\(newsId)"
        case .readNotification:
            return "/user/news/read"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNotificationList:
            return .get
        case .deleteNotification, .readNotification:
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
        case .readNotification(let newsIdList):
            return .requestBody(["unreadNews": newsIdList])
        }
    }
}
