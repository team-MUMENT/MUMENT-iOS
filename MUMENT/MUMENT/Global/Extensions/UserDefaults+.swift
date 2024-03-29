//
//  UserDefaults+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import Foundation

extension UserDefaults {
    
    /// UserDefaults key value가 많아지면 관리하기 어려워지므로 enum 'Keys'로 묶어 관리합니다.
    enum Keys {

        /// String
        static var recentSearch = "recentSearch"
        static var FCMTokenForDevice = "fcmToken"
        static var userId = "userId"
        static var accessToken = "accessToken"
        static var refreshToken = "refreshToken"
        static var isAppleLogin = "isAppleLogin"
    }
}
