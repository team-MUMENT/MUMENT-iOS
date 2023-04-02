//
//  EditMumentResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/30.
//

import Foundation

// MARK: - EditMumentResponseModel
struct EditMumentResponseModel: Codable {
    var id: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}
