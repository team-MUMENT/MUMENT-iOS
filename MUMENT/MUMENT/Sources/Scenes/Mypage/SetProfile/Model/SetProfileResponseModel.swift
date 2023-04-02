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
    var accessToken, refreshToken, userName, image: String
    
    enum CodingKeys: String, CodingKey {
        case id, accessToken, refreshToken, userName, image
    }
}
