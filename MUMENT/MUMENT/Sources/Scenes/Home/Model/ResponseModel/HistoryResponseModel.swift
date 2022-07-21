//
//  HistoryResponseMomdel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - HistoryResponseModel
struct HistoryResponseModel: Codable {
    let music: DataMusic
    let mumentHistory: [MumentHistory]

    enum CodingKeys: String, CodingKey {
        case music = "music"
        case mumentHistory = "mumentHistory"
    }
    
    
    // MARK: - MumentHistory
    struct MumentHistory: Codable {
        let music: MumentHistoryMusic
        let user: User
        let id: String
        let isFirst: Bool
        let impressionTag: [Int]
        let feelingTag: [Int]
        let content: String?
        let isPrivate: Bool
        let likeCount: Int
        let isDeleted: Bool
        let createdAt: String
        let updatedAt: String
        let v: Int
        let cardTag: [Int]
        let date: String
        let isLiked: Bool

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case id = "_id"
            case isFirst = "isFirst"
            case impressionTag = "impressionTag"
            case feelingTag = "feelingTag"
            case content = "content"
            case isPrivate = "isPrivate"
            case likeCount = "likeCount"
            case isDeleted = "isDeleted"
            case createdAt = "createdAt"
            case updatedAt = "updatedAt"
            case v = "__v"
            case cardTag = "cardTag"
            case date = "date"
            case isLiked = "isLiked"
        }
        
        // MARK: - MumentHistoryMusic
        struct MumentHistoryMusic: Codable {
            let id: String

            enum CodingKeys: String, CodingKey {
                case id = "_id"
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

    // MARK: - DataMusic
    struct DataMusic: Codable {
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

}
