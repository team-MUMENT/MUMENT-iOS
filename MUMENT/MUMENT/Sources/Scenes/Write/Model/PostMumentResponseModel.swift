//
//  PostMumentResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/21.
//

import Foundation

// MARK: - PostMumentResponseModel
struct PostMumentResponseModel: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}
