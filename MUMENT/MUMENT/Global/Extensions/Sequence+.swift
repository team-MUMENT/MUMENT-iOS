//
//  Sequence+.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/23.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
