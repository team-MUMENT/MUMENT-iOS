//
//  PostMumentBodyModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/21.
//

import Foundation

// MARK: - PostMumentBodyModel
struct PostMumentBodyModel: Codable {
    let isFirst: Bool
    let impressionTag: [Int]
    let feelingTag: [Int]
    let content: String
    let isPrivate: Bool

    enum CodingKeys: String, CodingKey {
        case isFirst = "isFirst"
        case impressionTag = "impressionTag"
        case feelingTag = "feelingTag"
        case content = "content"
        case isPrivate = "isPrivate"
    }
}
