//
//  File.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit

struct MumentWithHeartModel {
    let profileImageTitle: String
    var profileImage: UIImage? {
        return UIImage(named:profileImageTitle)
    }
    let writerName: String
    let albumImageTitle: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageTitle)
    }
    let songTitle: String
    let artistName:String
    let contentsLabel: String
    let createdAtLabel: String
    let isHeartFilled: Bool
    var heartImage: UIImage? {
        return isHeartFilled ? UIImage(named: "heart_filled") : UIImage(named: "heart")
    }
    let heartCount: Int
    
}

// MARK: - Extensions
extension MumentWithHeartModel {
    static var sampleData: [MumentWithHeartModel] = [
        MumentWithHeartModel(profileImageTitle:"image2",writerName:"이수지",albumImageTitle: "image4",songTitle:"Antifreeze",artistName: "백예린",contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.",createdAtLabel:"1 Sep, 2020",isHeartFilled:false,heartCount:15)
    ]
}
