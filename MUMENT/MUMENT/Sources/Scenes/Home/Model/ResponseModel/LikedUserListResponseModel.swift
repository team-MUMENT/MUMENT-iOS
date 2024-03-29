//
//  LikedUserListResponseModel.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/05.
//

import Foundation

struct LikedUserListResponseModel: Codable {
    let id: Int
    let userName: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, userName, image
    }
}
