//
//  GetBlockedUserListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/07.
//

import Foundation

// MARK: - GetBlockedUserListResponseModelElement
struct GetBlockedUserListResponseModelElement: Codable {
    var id: Int
    var image: String?
    var nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "profile_id"
        case image
    }
}

typealias GetBlockedUserListResponseModel = [GetBlockedUserListResponseModelElement]
