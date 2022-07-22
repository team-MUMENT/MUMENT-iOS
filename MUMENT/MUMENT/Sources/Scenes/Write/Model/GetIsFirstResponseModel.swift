//
//  GetIsFirstResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation

// MARK: - GetIsFirstResponseModel
struct GetIsFirstResponseModel: Codable {
    let isFirst: Bool
    let firstavailable: Bool

    enum CodingKeys: String, CodingKey {
        case isFirst = "isFirst"
        case firstavailable = "firstAvailable"
    }
}
