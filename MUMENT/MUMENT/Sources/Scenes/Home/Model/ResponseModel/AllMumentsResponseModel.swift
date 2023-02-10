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
        case mumentList
    }
    // MARK: - MumentList
    struct MumentList: Codable {
        let feelingTag: [Int]
        let updatedAt: String
        let musicId: String
        let id: Int
        var likeCount: Int
        let impressionTag: [Int]
        let isDeleted: Bool
        let cardTag: [Int]
        let isPrivate: Bool
        let date: String
        let isFirst: Bool
        var isLiked: Bool
        let user: User
        let createdAt: String
        let content: String?

        enum CodingKeys: String, CodingKey {
            case feelingTag
            case updatedAt
            case musicId
            case id = "_id"
            case likeCount
            case impressionTag
            case isDeleted
            case cardTag
            case isPrivate
            case date
            case isFirst
            case isLiked
            case user
            case createdAt
            case content
        }
    }
    // MARK: - User
    struct User: Codable {
        let id: Int
        let name: String
        let image: String?

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
            case image
        }
    }
}
