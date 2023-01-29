//
//  GetNotificationListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/21.
//

import Foundation

struct GetNotificationListResponseModelElement: Codable {
    var id: Int
    var type: String
    var userID: Int?
    var isDeleted, isRead: Bool
    var createdAt: String
    var linkID: Int
    var noticePoint, noticeTitle, likeProfileID, likeMusicTitle: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case userID = "userId"
        case isDeleted, isRead, createdAt
        case linkID = "linkId"
        case noticePoint, noticeTitle
        case likeProfileID = "likeProfileId"
        case likeMusicTitle
    }
}

typealias GetNotificationListResponseModel = [GetNotificationListResponseModelElement]
