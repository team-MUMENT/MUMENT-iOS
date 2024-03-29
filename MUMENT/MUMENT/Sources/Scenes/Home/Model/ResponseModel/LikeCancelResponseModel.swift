//
//  LikeCancelResponceModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/31.
//

import Foundation

// MARK: - HistoryResponseModel
struct LikeCancelResponseModel: Codable {
    let likeCount: Int

    enum CodingKeys: String, CodingKey {
        case likeCount
    }
}
