//
//  UserDefaultsManager.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/11.
//

import Foundation

struct UserDefaultsManager {

    static var userId: Int? {
        get { return UserDefaults.standard.integer(forKey: UserDefaults.Keys.userId) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.userId) }
    }
    
    static var accessToken: String? {
        get { return UserDefaults.standard.string(forKey: UserDefaults.Keys.accessToken) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.accessToken) }
    }
    
    static var refreshToken: String? {
        get { return UserDefaults.standard.string(forKey: UserDefaults.Keys.refreshToken) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.refreshToken) }
    }
    
    static var fcmToken: String? {
        get { return UserDefaults.standard.string(forKey: UserDefaults.Keys.FCMTokenForDevice) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.FCMTokenForDevice) }
    }
    
    static var isAppleLogin: Bool? {
        get { return UserDefaults.standard.bool(forKey: UserDefaults.Keys.isAppleLogin) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.isAppleLogin) }
    }
}
