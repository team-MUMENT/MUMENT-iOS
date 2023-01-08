//
//  GetLikedMumentResponseModel.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/22.
//

import Foundation

// MARK: - GetLikedMumentResponseModel
struct GetLikedMumentResponseModel: Codable {
    let muments: [Mument]
    
    // MARK: - Mument
    struct Mument: Codable {
        let id: String
        let user: User
        let music: Music
        let isFirst: Bool
        let impressionTag, feelingTag, cardTag: [Int]
        let content: String?
        let isPrivate, isLiked: Bool
        let createdAt: String
        let year, month: Int

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case user, music, isFirst, impressionTag, feelingTag, cardTag, content, isPrivate, isLiked, createdAt, year, month
        }
    }

}

