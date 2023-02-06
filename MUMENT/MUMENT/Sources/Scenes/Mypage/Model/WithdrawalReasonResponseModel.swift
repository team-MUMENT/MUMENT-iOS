//
//  WithdrawalReasonResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Foundation

struct WithdrawalReasonResponseModel: Codable {
    let id: Int
    let userId: Int
    let userName: String
    let leaveCategoryId: Int
    let leaveCategoryName: String
    let reasonEtc: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case userName = "userName"
        case leaveCategoryId = "leaveCategoryId"
        case leaveCategoryName = "leaveCategoryName"
        case reasonEtc = "reasonEtc"
        case createdAt = "createdAt"
    }
}
