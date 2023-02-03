//
//  UserInfo.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import UIKit

class UserInfo {
    static var shared = UserInfo()
    
    init() { }
    
    var userId: Int?
    var accessToken: String? = ""
    var refreshToken: String? = ""
    var nickname: String = ""
    var profileImageURL: String = "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg"
}
