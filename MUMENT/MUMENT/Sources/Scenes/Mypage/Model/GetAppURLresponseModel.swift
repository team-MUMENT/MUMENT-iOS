//
//  GetAppURLresponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/03.
//

import Foundation

// MARK: - GetAppURLresponseModel
struct GetAppURLresponseModel: Codable {
    var faq, contact, appInfo, introduction, tos, privacy, license: String?
    
    init() {
        self.faq = ""
        self.contact = ""
        self.appInfo = ""
        self.introduction = ""
        self.tos = ""
        self.privacy = ""
        self.license = ""
    }
}
