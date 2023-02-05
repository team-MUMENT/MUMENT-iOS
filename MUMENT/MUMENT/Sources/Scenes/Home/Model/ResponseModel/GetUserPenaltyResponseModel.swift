//
//  GetUserPenaltyResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/04.
//

import Foundation

// MARK: - GetUserPenaltyResponseModel
struct GetUserPenaltyResponseModel: Codable {
    var restricted: Bool
    var reason, musicArtist, musicTitle, endDate, period: String?
}
