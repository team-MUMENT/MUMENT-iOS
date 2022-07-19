//
//  NetworkResult.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/11.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
