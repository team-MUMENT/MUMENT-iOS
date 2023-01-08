//
//  Entity.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/09.
//

import Foundation

struct StorageMumentModel {
    let id: String
    let user: User
    let music: Music
    let isFirst: Bool
    let impressionTag, feelingTag, cardTag: [Int]
    let content: String?
    let isPrivate, isLiked: Bool
    let createdAt: String
    let year, month: Int
    let likeCount: Int?
    
}

// MARK: - Music
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

// MARK: - User
struct User: Codable {
  let id: String
  let image: String?
  let name: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case image = "image"
    case name = "name"
  }
}
