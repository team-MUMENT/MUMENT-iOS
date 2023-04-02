//
//  LikeResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/23.
//

import Foundation

// MARK: - HistoryResponseModel
struct LikeResponseModel: Codable {
    let mumentId: Int
    let likeCount: Int
    let pushSuccess: Bool

    enum CodingKeys: String, CodingKey {
        case mumentId
        case likeCount
        case pushSuccess
    }
}
