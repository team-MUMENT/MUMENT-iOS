//
//  NotificationInfo.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/23.
//

import Foundation

class NotificationInfo {
    
    /// 푸시알림을 클릭해서 앱에 진입했는지에 대한 정보를 저장해두기 위한 싱글톤 객체 선언
    static let shared = NotificationInfo()
    
    var isPushComes: Bool = false
    private init() { }
}
