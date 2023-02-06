//
//  WithdrawalResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Foundation

struct WithdrawalResponseModel: Codable {
    let id: String
    let userName: String
    let isDeleted: Bool
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "userName"
        case isDeleted = "isDeleted"
        case updatedAt = "updatedAt"
    }
}
