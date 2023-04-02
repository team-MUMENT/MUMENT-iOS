//
//  MumentForTodayResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - MumentForTodayResponseModel
struct MumentForTodayResponseModel: Codable {
    let todayMument: TodayMument
    let todayDate: String
    
    // MARK: - TodayMument
    struct TodayMument: Codable {
        let isFirst: Bool
        let content: String
        let mumentID: Int
        let cardTag, impressionTag: [Int]
        let displayDate, date: String
        let music: Music
        let createdAt: String
        let feelingTag: [Int]
        let user: User

        enum CodingKeys: String, CodingKey {
            case isFirst, content
            case mumentID = "mumentId"
            case cardTag, impressionTag, displayDate, date, music, createdAt, feelingTag, user
        }
    }

    // MARK: - Music
    struct Music: Codable {
        let id, name: String
        let image: String
        let artist: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, image, artist
        }
    }

    // MARK: - User
    struct User: Codable {
        let id: Int
        let name: String
        let image: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, image
        }
    }
}
