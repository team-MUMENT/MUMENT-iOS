//
//  SignInDataModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

struct SignInResponseModel: Codable {
    let id: String
    let type: String
    let email: String
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type = "type"
        case email = "email"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
