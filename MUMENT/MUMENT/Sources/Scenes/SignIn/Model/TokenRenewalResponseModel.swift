//
//  TokenRenewalResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/24.
//

import Foundation

struct TokenRenewalResponseModel: Codable {
    let id: Int
    let type: String
    let accessToken: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type = "type"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
