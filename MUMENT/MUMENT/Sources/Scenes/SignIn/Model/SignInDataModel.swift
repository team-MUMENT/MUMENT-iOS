//
//  SignInDataModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

struct SignInDataModel: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}
