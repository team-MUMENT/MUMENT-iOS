//
//  UserInfo.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()
    
    private init() { }
    
    var userId: String?
}
