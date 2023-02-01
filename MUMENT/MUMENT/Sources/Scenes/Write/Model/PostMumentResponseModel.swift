//
//  PostMumentResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/21.
//

import Foundation

// MARK: - PostMumentResponseModel
struct PostMumentResponseModel: Codable {
    let id: Int
    let count: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case count
    }
}
