//
//  UserDefaultsManager.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/11.
//

import Foundation

struct UserDefaultsManager {

    static var userId: Int? {
        get { return UserDefaults.standard.integer(forKey: "userId") }
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
