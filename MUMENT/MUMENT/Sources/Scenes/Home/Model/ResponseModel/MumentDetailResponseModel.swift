//
//  MumentDetailResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - MumentDetailResponseModel
struct MumentDetailResponseModel: Codable {
    let isFirst: Bool
    let content: String?
    let impressionTag: [Int]
    let isLiked: Bool
    let count: Int
    let music: Music
    let likeCount: Int
    let createdAt: String
    let feelingTag: [Int]
    let user: User

    enum CodingKeys: String, CodingKey {
        case isFirst = "isFirst"
        case content = "content"
        case impressionTag = "impressionTag"
        case isLiked = "isLiked"
        case count = "count"
        case music = "music"
        case likeCount = "likeCount"
        case createdAt = "createdAt"
        case feelingTag = "feelingTag"
        case user = "user"
    }
    
    // MARK: - Music
    struct Music: Codable {
        let id: String
        let name: String
        let image: String?
        let artist: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case image = "image"
            case artist = "artist"
        }
    }

    // MARK: - User
    struct User: Codable {
        let id: String
        let image: String?
        let name: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case image = "image"
            case name = "name"
        }
    }

}
