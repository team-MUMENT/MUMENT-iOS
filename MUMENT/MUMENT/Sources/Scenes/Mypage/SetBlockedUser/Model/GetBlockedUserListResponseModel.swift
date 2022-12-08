//
//  GetBlockedUserListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/07.
//

import Foundation

// MARK: - GetBlockedUserListResponseModelElement
struct GetBlockedUserListResponseModelElement: Codable {
    var id: String
    var image: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image, name
    }
}

typealias GetBlockedUserListResponseModel = [GetBlockedUserListResponseModelElement]
