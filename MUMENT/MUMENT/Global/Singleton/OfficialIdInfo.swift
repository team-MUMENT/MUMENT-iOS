//
//  OfficialIdInfo.swift
//  MUMENT
//
//  Created by madilyn on 2023/03/10.
//

import Foundation

class OfficialIdInfo {
    
    static let shared = OfficialIdInfo()
    
    var idList: [Int] = []
    private init() { }
}
