//
//  PostMumentBodyModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/21.
//

import Foundation

// MARK: - PostMumentBodyModel
struct PostMumentBodyModel: Codable {
    var isFirst: Bool
    var impressionTag: [Int]
    var feelingTag: [Int]
    var content: String
    var isPrivate: Bool

    enum CodingKeys: String, CodingKey {
        case isFirst = "isFirst"
        case impressionTag = "impressionTag"
        case feelingTag = "feelingTag"
        case content = "content"
        case isPrivate = "isPrivate"
    }
}
