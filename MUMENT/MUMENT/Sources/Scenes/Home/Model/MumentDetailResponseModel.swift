//
//  MumentDetailResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - DataClass
struct MumentDetailResponseModel: Codable {
    let user: Music
    let music: Music
    let isFirst: Bool
    let impressionTag: [Int]
    let feelingTag: [Int]
    let content: String
    let likeCount: Int
    let isLiked: Bool
    let createdAt: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case music = "music"
        case isFirst = "isFirst"
        case impressionTag = "impressionTag"
        case feelingTag = "feelingTag"
        case content = "content"
        case likeCount = "likeCount"
        case isLiked = "isLiked"
        case createdAt = "createdAt"
        case count = "count"
    }
}

// MARK: - Music
struct Music: Codable {
    let id: String
    let name: String
    let artist: String?
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case artist = "artist"
        case image = "image"
    }
}


