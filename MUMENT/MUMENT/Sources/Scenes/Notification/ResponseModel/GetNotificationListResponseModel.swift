//
//  GetNotificationListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/21.
//

import Foundation

// MARK: - GetNotificationListResponseModelElement
struct GetNotificationListResponseModelElement: Codable {
    var id: Int
    var type: String
    var userID: Int
    var isDeleted, isRead: Bool
    var createdAt: String
    var linkID: Int
    var notice: Notice
    var like: Like

    enum CodingKeys: String, CodingKey {
        case id, type
        case userID = "userId"
        case isDeleted, isRead, createdAt
        case linkID = "linkId"
        case notice, like
    }
    
    // MARK: - Like
    struct Like: Codable {
        var userName: String?
        var music: Music
    }

    // MARK: - Music
    struct Music: Codable {
        var id, name, artist: String?
        var image: String?
    }

    // MARK: - Notice
    struct Notice: Codable {
        var point, title: String?
    }
}

typealias GetNotificationListResponseModel = [GetNotificationListResponseModelElement]
