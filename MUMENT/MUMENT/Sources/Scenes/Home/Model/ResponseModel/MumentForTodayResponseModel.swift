//
//  MumentForTodayResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

struct MumentForTodayResponseModel: Codable {
    let id: String
    let music: Music
    let user: User
    let isFirst: Bool
    let impressionTag: [Int]
    let feelingTag: [Int]
    let content: String?
    let isPrivate: Bool
    let likeCount: Int
    let isDeleted: Bool
    let createdAt: String
    let isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case music = "music"
        case user = "user"
        case isFirst = "isFirst"
        case impressionTag = "impressionTag"
        case feelingTag = "feelingTag"
        case content = "content"
        case isPrivate = "isPrivate"
        case likeCount = "likeCount"
        case isDeleted = "isDeleted"
        case createdAt = "createdAt"
        case isLiked = "isLiked"
    }
    
    // MARK: - Music
    struct Music: Codable {
        let id: String
        let name: String
        let artist: String
        let image: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case artist = "artist"
            case image = "image"
        }
    }

    // MARK: - User
    struct User: Codable {
        let id: String
        let name: String
        let image: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case image = "image"
        }
    }

}

