//
//  UIImage+.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/02.
//

import UIKit

extension UIImage {
    
    /// URL을 통해 이미지를 불러오는 메서드 + 캐싱
    func setImageUrl(_ imageURL: String) -> UIImage {
        let cacheKey = NSString(string: imageURL)
        var resultImage = UIImage(named: "mumentDefaultProfile")
        /// 해당 Key에 캐시 이미지가 저장되어 있으면 이미지 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            return cachedImage
        }
        
        if let requestURL = URL(string: imageURL) {
            let request = URLRequest(url: requestURL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data,
                    let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                    let image = UIImage(data: data) {
                    
                    /// 다운받은 이미지를 캐시에 저장
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    resultImage = image
                }
            }.resume()
        }
        return resultImage ?? UIImage()
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
