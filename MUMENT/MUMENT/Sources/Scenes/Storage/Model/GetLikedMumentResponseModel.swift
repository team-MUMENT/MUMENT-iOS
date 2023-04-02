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
    
    enum CodingKeys: String, CodingKey {
      case muments = "muments"
    }
    
    // MARK: - Mument
    struct Mument: Codable {
        let id: Int
        let user: User
        let music: Music
        let isFirst: Bool
        let allCardTag: [Int]
        let cardTag: [Int]
        let content: String?
        let isPrivate: Bool
        let likeCount: Int
        let isLiked: Bool
        let createdAt: String
        let year: Int
        let month: Int

        enum CodingKeys: String, CodingKey {
           case id = "_id"
           case user = "user"
           case music = "music"
           case isFirst = "isFirst"
           case allCardTag = "allCardTag"
           case cardTag = "cardTag"
           case content = "content"
           case isPrivate = "isPrivate"
           case likeCount = "likeCount"
           case isLiked = "isLiked"
           case createdAt = "createdAt"
           case year = "year"
           case month = "month"
         }
    }
}

