//
//  GetNoticeListResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import Foundation

// MARK: - GetNoticeListResponseModelElement
struct GetNoticeListResponseModelElement: Codable {
    var id, title, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, createdAt
    }
}

typealias GetNoticeListResponseModel = [GetNoticeListResponseModelElement]
