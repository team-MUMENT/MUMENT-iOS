//
//  GetNoticeResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import Foundation

// MARK: - GetNoticeResponseModel
struct GetNoticeResponseModel: Codable {
    var title, createdAt, content: String
}
