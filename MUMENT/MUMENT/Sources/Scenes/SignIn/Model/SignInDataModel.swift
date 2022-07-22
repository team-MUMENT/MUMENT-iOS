//
//  SignInDataModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

struct SignInDataModel: Codable {
    let id: String
    let profileID: String
    let name: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileID = "profileId"
        case name = "name"
        case image = "image"
    }
}
