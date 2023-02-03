//
//  GetNoticeListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import Foundation

// MARK: - GetNoticeListResponseModelElement
struct GetNoticeListResponseModelElement: Codable {
    var id: Int
    var title, content, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, content
        case createdAt = "created_at"
    }
}

typealias GetNoticeListResponseModel = [GetNoticeListResponseModelElement]
