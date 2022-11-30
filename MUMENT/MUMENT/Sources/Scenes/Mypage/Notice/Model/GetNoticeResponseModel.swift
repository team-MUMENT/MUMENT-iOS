//
//  GetNoticeResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import Foundation

// MARK: - GetNoticeListResponseModel
struct GetNoticeResponseModel: Codable {
    var title, createdAt, content: String
}
