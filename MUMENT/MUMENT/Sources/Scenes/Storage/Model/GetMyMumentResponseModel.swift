//
//  GetMyMumentStorageResponseModel.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/21.
//

import Foundation

/// MARK: - GetMyMumentStorageResponseModel
struct GetMyMumentResponseModel: Codable {
  let muments: [Mument]

  enum CodingKeys: String, CodingKey {
    case muments = "muments"
  }
  // MARK: - Mument
  struct Mument: Codable {
    let feelingTag: [Int]
    let music: Music
    let id: String
    let likeCount: Int
    let impressionTag: [Int]
    let cardTag: [Int]
    let isPrivate: Bool
    let isLiked: Bool
    let isFirst: Bool
    let year: Int
    let month: Int
    let user: User
    let createdAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
      case feelingTag = "feelingTag"
      case music = "music"
      case id = "_id"
      case likeCount = "likeCount"
      case impressionTag = "impressionTag"
      case cardTag = "cardTag"
      case isPrivate = "isPrivate"
      case isLiked = "isLiked"
      case isFirst = "isFirst"
      case year = "year"
      case month = "month"
      case user = "user"
      case createdAt = "createdAt"
      case content = "content"
    }
  }
}
