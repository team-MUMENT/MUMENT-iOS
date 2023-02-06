//
//  GetUserProfileResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/03.
//

import Foundation

// MARK: - GetUserProfileResponseModel
struct GetUserProfileResponseModel: Codable {
    var id: Int
    var userName: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case image
    }
}
