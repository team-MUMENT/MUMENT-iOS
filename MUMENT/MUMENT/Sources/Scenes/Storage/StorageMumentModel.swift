//
//  Entity.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/09.
//

import Foundation

struct StorageMumentModel {
    let id: Int
    let user: User
    let music: Music
    let isFirst: Bool
    let allCardTag,cardTag: [Int]
    let content: String?
    let isPrivate: Bool
    var isLiked: Bool
    let createdAt: String
    let year, month: Int
    var likeCount: Int
}

// MARK: - User
struct User: Codable {
  let id: Int
  let image: String?
  let name: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case image = "image"
    case name = "name"
  }
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

