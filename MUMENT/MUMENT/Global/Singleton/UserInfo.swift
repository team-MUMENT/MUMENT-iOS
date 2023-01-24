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
    var accessToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsInByb2ZpbGVJZCI6bnVsbCwiaW1hZ2UiOm51bGwsImlhdCI6MTY3MzgwODMyNCwiZXhwIjoxNjc2NDAwMzI0LCJpc3MiOiJNdW1lbnQifQ.dywLT7ymxSQatKZY1jritgAB0w1V_qGi48ORFY_3TtM"
    var refreshToken: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsInByb2ZpbGVJZCI6bnVsbCwiaW1hZ2UiOm51bGwsImlhdCI6MTY3MzgwODMyNCwibmJmIjoxNjc2NDAwMzI0LCJleHAiOjE2Nzg5OTIzMjQsImlzcyI6Ik11bWVudCJ9.xeVUW00d16Y-cw6l4yI6EjwzvWa8nhQw3mS1W1cLcJI"
    
    var getAccessToken: String? { return self.accessToken }
}
