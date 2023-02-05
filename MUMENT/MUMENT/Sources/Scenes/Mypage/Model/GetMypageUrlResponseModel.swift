//
//  GetMypageUrlResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/03.
//

import Foundation

// MARK: - GetMypageURLResponseModel
struct GetMypageURLResponseModel: Codable {
    var faq, contact, appInfo, introduction, tos, privacy: String?
    
    init() {
        self.faq = ""
        self.contact = ""
        self.appInfo = ""
        self.introduction = ""
        self.tos = ""
        self.privacy = ""
    }
}
