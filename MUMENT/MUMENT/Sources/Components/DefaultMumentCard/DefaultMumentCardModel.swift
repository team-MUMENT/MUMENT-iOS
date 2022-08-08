//
//  File.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit

struct DefaultMumentCardModel {
    let profileImageTitle: String
    var profileImage: UIImage? {
        return UIImage(named:profileImageTitle)
    }
    let writerName: String
    let albumImageTitle: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageTitle)
    }
    let isFirst: Bool
    let impressionTags: [Int]
    let feelingTags: [Int]
    let songTitle: String
    let artistName:String
    let contents: String
    let createdAt: String
    let isLiked: Bool
    var heartImage: UIImage? {
        return isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart")
    }
    let heartCount: Int
    
}

// MARK: - Extensions
extension DefaultMumentCardModel {
    static var sampleData: [DefaultMumentCardModel] = [
        DefaultMumentCardModel(profileImageTitle:"image3", writerName:"이수지1", albumImageTitle: "image4", isFirst:true, impressionTags: [100,101], feelingTags:[], songTitle:"Antifreeze", artistName: "백예린", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:true, heartCount:10),
        DefaultMumentCardModel(profileImageTitle:"image2", writerName:"이수지2", albumImageTitle: "image4", isFirst:false, impressionTags: [105,101], feelingTags:[201], songTitle:"Antifreeze", artistName: "백예린", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:5),
        DefaultMumentCardModel(profileImageTitle:"image4", writerName:"이수지3", albumImageTitle: "image4", isFirst:false, impressionTags: [102], feelingTags:[202], songTitle:"Antifreeze", artistName: "백예린", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:8),
        DefaultMumentCardModel(profileImageTitle:"image5", writerName:"이수지4", albumImageTitle: "image4", isFirst:true, impressionTags: [103,104], feelingTags:[203], songTitle:"Antifreeze", artistName: "백예린", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:true, heartCount:3)
    ]
}
