//
//  WithdrawalReasonBodyModel.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//
import Foundation

struct WithdrawalReasonBodyModel: Codable {
    var leaveCategoryId: Int
    var reasonEtc: String
}
