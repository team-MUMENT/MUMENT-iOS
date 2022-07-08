//
//  NSObject+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
