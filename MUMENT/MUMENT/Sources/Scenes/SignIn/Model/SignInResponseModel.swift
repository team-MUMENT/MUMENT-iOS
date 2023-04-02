//
//  SignInDataModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

struct SignInResponseModel: Codable {
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
