//
//  SongInfoResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//
////
import Foundation

// MARK: - SongInfoResponseModel
struct SongInfoResponseModel: Codable {
    let music: Music
    let myMument: MyMument?

    enum CodingKeys: String, CodingKey {
        case music = "music"
        case myMument = "myMument"
    }
    
    // MARK: - SongInfoResponseModelMusic
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

    // MARK: - MyMument
    struct MyMument: Codable {
        let feelingTag: [Int]
        let updatedAt: String
        let music: MyMumentMusic
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
        
        // MARK: - MyMumentMusic
        struct MyMumentMusic: Codable {
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
}
