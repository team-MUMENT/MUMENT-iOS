//
//  CellCategory.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/16.
//

import UIKit

enum CellCategory: Int {
    case listCell
    case albumCell
    
    var cellSize: CGSize {
        switch self {
        case .listCell:
            return CGSize(width: 300, height: 200)
        case .albumCell:
            return CGSize(width: 100, height: 100)
        }
    }
}
