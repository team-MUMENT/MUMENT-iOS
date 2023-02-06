//
//  UserBlockResponseModel.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/07.
//

import Foundation

struct UserBlockResponseModel: Codable {
    let exist: Int
    
    enum CodingKeys: String, CodingKey {
        case exist
    }
}
