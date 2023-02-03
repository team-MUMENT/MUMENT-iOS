//
//  String+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

extension String {
    
    /// 태그 String을 Int로 반환하는 메서드
    func tagInt() -> Int? {
        if self == "🎙 음색" {
            return 100
        } else if self == "🥁 비트" {
            return 101
        } else if self == "🖋 가사" {
            return 102
        } else if self == "🎶 멜로디" {
            return 103
        } else if self == "🎸 베이스" {
            return 104
        } else if self == "🛫 도입부" {
            return 105
        } else if self == "🎡 벅참" {
            return 200
        } else if self == "😄 신남" {
            return 201
        } else if self == "💐 설렘" {
            return 202
        } else if self == "😚 행복" {
            return 203
        } else if self == "🙌 자신감" {
            return 204
        } else if self == "🍀 여유로움" {
            return 205
        } else if self == "🍁 센치함" {
            return 206
        } else if self == "😔 우울" {
            return 207
        } else if self == "🕰 그리움" {
            return 208
        } else if self == "🛌 외로움" {
            return 209
        } else if self == "🌋 스트레스" {
            return 210
        } else if self == "⌛️ 아련함" {
            return 211
        } else if self == "💭 회상" {
            return 212
        } else if self == " 👥 위로" {
            return 213
        } else if self == "🌅 낭만" {
            return 214
        } else if self == "☕️ 차분" {
            return 215
        } else {
            return nil
        }
    }
    
    /// String을 UIImage로 반환하는 메서드
    func makeImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    /// 서버에서 들어온 Date String을 Date 타입으로 반환하는 메서드
    private func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("toDate() convert error")
            return Date()
        }
    }
    
    /// serverTimeToString의 용도 정의
    enum TimeStringCase {
        case forNotification
        case forDefault
    }
    
    /// 서버에서 들어온 Date String을 UI에 적용 가능한 String 타입으로 반환하는 메서드
    func serverTimeToString(forUse: TimeStringCase) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"
        
        let currentTime = Int(Date().timeIntervalSince1970)
        
        switch forUse {
        case .forNotification:
            let getTime = self.toDate().timeIntervalSince1970
            let displaySec = currentTime - Int(getTime)
            let displayMin = displaySec / 60
            let displayHour = displayMin / 60
            let displayDay = displayHour / 24
            
            if displayDay >= 1 {
                return dateFormatter.string(from: self.toDate())
            } else if displayHour >= 1 {
                return "\(displayHour)시간 전"
            } else if displayMin >= 1 {
                return "\(displayMin)분 전"
            } else {
                return "1분 전"
            }
        case .forDefault:
            return dateFormatter.string(from: self.toDate())
        }
    }
    
    func replaceNewLineKeyword() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    func getImage(completion: @escaping (UIImage) -> ()){
        let cacheKey = NSString(string: self)
        
        /// 해당 Key에 캐시 이미지가 저장되어 있으면 이미지 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            completion(cachedImage)
        }
        
        if let requestURL = URL(string: self) {
            let request = URLRequest(url: requestURL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data,
                   let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                   let image = UIImage(data: data) {
                    
                    /// 다운받은 이미지를 캐시에 저장
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    completion(image)
                }
            }.resume()
        }
    }
}
