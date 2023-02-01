//
//  SetProfileResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/02.
//

import Foundation

// MARK: - SetProfileResponseModel
struct SetProfileResponseModel: Codable {
    var id: Int
    var accessToken, refreshToken, nickname, image: String
    
    enum CodingKeys: String, CodingKey {
        case id, accessToken, refreshToken
        case nickname = "profileId"
        case image
    }
}
