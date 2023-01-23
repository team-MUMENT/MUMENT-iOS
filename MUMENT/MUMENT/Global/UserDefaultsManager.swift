//
//  UserDefaultsManager.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/11.
//

import Foundation

struct UserDefaultsManager {
    static var isAppleLogin: Bool {
        get { return UserDefaults.standard.bool(forKey: "isAppleLogin") }
        set { UserDefaults.standard.set(newValue, forKey: "isAppleLogin") }
    }
    
    static var isOnboarding: String? {
        get { return UserDefaults.standard.string(forKey: "isOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "isOnboarding") }
    }

    static var userId: String? {
        get { return UserDefaults.standard.string(forKey: "userId") }
        set { UserDefaults.standard.set(newValue, forKey: "userId") }
    }
    
    static var accessToken: String? {
        get { return UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }
    
    static var refreshToken: String? {
        get { return UserDefaults.standard.string(forKey: "refreshToken") }
        set { UserDefaults.standard.set(newValue, forKey: "refreshToken") }
    }
    
    static var fcmToken: String? {
        get { return UserDefaults.standard.string(forKey: "fcmToken") }
        set { UserDefaults.standard.set(newValue, forKey: "fcmToken") }
    }
}
