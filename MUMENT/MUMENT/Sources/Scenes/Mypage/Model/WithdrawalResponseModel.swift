//
//  WithdrawalResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Foundation

struct WithdrawalResponseModel: Codable {
    let id: String
    let profileId: String
    let isDeleted: Bool
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileId = "profileId"
        case isDeleted = "isDeleted"
        case updatedAt = "updatedAt"
    }
}
