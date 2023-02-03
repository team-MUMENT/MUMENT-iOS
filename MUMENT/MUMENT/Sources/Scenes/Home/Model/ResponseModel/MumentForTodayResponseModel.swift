//
//  MumentForTodayResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - HistoryResponseModel
struct MumentForTodayResponseModel: Codable {
    let todayDate: String
    let todayMument: TodayMument

    enum CodingKeys: String, CodingKey {
        case todayDate = "todayDate"
        case todayMument = "todayMument"
    }
    
    // MARK: - TodayMument
    struct TodayMument: Codable {
        let music: Music
        let user: User
        let mumentId: Int
        let isFirst: Bool
        let impressionTag: [Int]
        let feelingTag: [Int]
        let content: String
        let cardTag: [Int]
        let createdAt: String
        let date: String
        let displayDate: String

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case mumentId = "mumentId"
            case isFirst = "isFirst"
            case impressionTag = "impressionTag"
            case feelingTag = "feelingTag"
            case content = "content"
            case cardTag = "cardTag"
            case createdAt = "createdAt"
            case date = "date"
            case displayDate = "displayDate"
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
            let id: Int
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

