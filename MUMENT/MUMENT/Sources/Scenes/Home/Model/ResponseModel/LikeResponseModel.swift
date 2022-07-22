//
//  LikeResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//

import Foundation

// MARK: - HistoryResponseModel
struct LikeResponseModel: Codable {
    let mumentID: String
    let likeCount: Int

    enum CodingKeys: String, CodingKey {
        case mumentID = "mumentId"
        case likeCount = "likeCount"
    }
}
