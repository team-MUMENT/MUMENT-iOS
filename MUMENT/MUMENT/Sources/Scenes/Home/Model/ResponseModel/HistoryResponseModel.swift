//
//  HistoryResponseMomdel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - HistoryResponseModel
struct HistoryResponseModel: Codable {
    let mumentHistory: [MumentHistory]
    
    enum CodingKeys: String, CodingKey {
        case mumentHistory = "mumentHistory"
    }
    
    
    // MARK: - MumentHistory
    struct MumentHistory: Codable {
        let id: Int
        let musicId: String
        let user: User
        let isFirst: Bool
        let impressionTag, feelingTag, cardTag: [Int]
        let content: String?
        let isPrivate: Bool
        var likeCount: Int
        let isDeleted: Bool
        let createdAt, updatedAt, date: String
        var isLiked: Bool
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case musicId, user, isFirst, impressionTag, feelingTag, cardTag, content, isPrivate, likeCount, isDeleted, createdAt, updatedAt, date, isLiked
        }
    }
    
    // MARK: - User
    struct User: Codable {
        let id: Int
        let name: String
        let image: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, image
        }
    }
}
