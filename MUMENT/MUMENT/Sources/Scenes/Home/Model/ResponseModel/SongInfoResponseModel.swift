//
//  SongInfoResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//
import Foundation

// MARK: - SongInfoResponseModel
struct SongInfoResponseModel: Codable {
    let music: Music
    let myMument: MyMument?

    enum CodingKeys: String, CodingKey {
        case music
        case myMument
    }
    
    // MARK: - Music
    struct Music: Codable {
        let id: String
        let name: String
        let image: String
        let artist: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
            case image
            case artist
        }
    }
    
    // MARK: - MyMument
    struct MyMument: Codable {
        let feelingTag: [Int]
        let updatedAt: String
        let music: MyMumentMusic
        let id: Int
        let likeCount: Int
        let impressionTag: [Int]
        let isDeleted: Bool
        let cardTag: [Int]
        let isPrivate: Bool
        let date: String
        let isFirst: Bool
        let isLiked: Bool
        let user: User
        let createdAt: String
        let content: String?

        enum CodingKeys: String, CodingKey {
            case feelingTag
            case updatedAt
            case music
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
        
        // MARK: - MyMumentMusic
        struct MyMumentMusic: Codable {
            let id: String

            enum CodingKeys: String, CodingKey {
                case id = "_id"
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
}
