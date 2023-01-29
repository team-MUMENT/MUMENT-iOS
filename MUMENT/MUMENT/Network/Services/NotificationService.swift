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
}

extension NotificationService: TargetType {
    var path: String {
        switch self {
        case .getNotificationList:
            return "/user/news"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNotificationList:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getNotificationList:
            return .auth
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getNotificationList:
            return .requestPlain
        }
    }
}
