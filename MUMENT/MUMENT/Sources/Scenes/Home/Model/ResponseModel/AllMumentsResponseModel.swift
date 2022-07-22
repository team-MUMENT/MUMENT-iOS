//
//  AllMumentsResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

struct AllMumentsResponseModel: Codable {
    let mumentList: [MumentList]

    enum CodingKeys: String, CodingKey {
        case mumentList = "mumentList"
    }
    // MARK: - MumentList
    struct MumentList: Codable {
        let feelingTag: [Int]
        let updatedAt: String
        let music: Music
        let id: String
        let likeCount: Int
        let impressionTag: [Int]
        let isDeleted: Bool
        let isPrivate: Bool
        let cardTag: [Int]
        let date: String
        let isFirst: Bool
        let isLiked: Bool
        let v: Int
        let user: User
        let createdAt: String
        let content: String?

        enum CodingKeys: String, CodingKey {
            case feelingTag = "feelingTag"
            case updatedAt = "updatedAt"
            case music = "music"
            case id = "_id"
            case likeCount = "likeCount"
            case impressionTag = "impressionTag"
            case isDeleted = "isDeleted"
            case isPrivate = "isPrivate"
            case cardTag = "cardTag"
            case date = "date"
            case isFirst = "isFirst"
            case isLiked = "isLiked"
            case v = "__v"
            case user = "user"
            case createdAt = "createdAt"
            case content = "content"
        }
    }

    // MARK: - Music
    struct Music: Codable {
        let id: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
        }
    }

    // MARK: - User
    struct User: Codable {
        let id: String
        let name: String
        let image: String?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case image = "image"
        }
    }

}
