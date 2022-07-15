//
//  ImageCacheManager.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit

/// 캐시를 저장해 놓을 싱글톤 클래스
class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
