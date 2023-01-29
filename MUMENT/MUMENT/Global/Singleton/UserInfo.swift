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
    var accessToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDAsInByb2ZpbGVJZCI6Iu2FjOyKpO2KuDIiLCJpbWFnZSI6bnVsbCwiaWF0IjoxNjc0OTMyODA1LCJleHAiOjE2Nzc1MjQ4MDUsImlzcyI6Ik11bWVudCJ9.xfWBuIEC8h75pwSWfFowPByIhwyeriJmyls8h-BmcEM"
    var refreshToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDAsInByb2ZpbGVJZCI6Iu2FjOyKpO2KuDIiLCJpbWFnZSI6bnVsbCwiaWF0IjoxNjc0OTMyODA1LCJleHAiOjE2ODAxMTY4MDUsImlzcyI6Ik11bWVudCJ9.qTSYY9E3B5nNpfAYI2BWvr_hM1MA99zIrLCEZohDVHc"
}
