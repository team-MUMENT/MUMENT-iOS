//
//  UIImageView+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit

extension UIImageView {
    
    /// 그냥 컬러만 있는 Image를 ImageView에 넣어 주는 메서드
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    /// URL을 통해 이미지를 불러오는 메서드
    func setImageUrl(_ url: String) {
        let cacheKey = NSString(string: url)
        
        /// 해당 Key에 캐시 이미지가 저장되어 있으면 이미지 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: url) {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        
                        /// 다운받은 이미지를 캐시에 저장
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self.image = image
                    }
                }
            }
        }
    }
//
//    extension UIImageView {
//        func load(_ URLAddress: String) {
//            guard let url = URL(string: URLAddress) else {
//                return
//            }
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self?.image = image.resizeImage()
//                        }
//                    }
//                }
//            }
//        }
//    }
}
