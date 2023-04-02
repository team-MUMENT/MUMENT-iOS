//
//  GetIsNewNotificationResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/06.
//

import Foundation

// MARK: - GetIsNewNotificationResponseModel
struct GetIsNewNotificationResponseModel: Codable {
    var exist: Bool
    var officialIdList: [Int]
}
