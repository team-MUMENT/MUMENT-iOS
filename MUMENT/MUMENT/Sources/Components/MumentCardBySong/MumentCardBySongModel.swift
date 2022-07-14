//
//  MumentCardBySongModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit

struct MumentCardBySongModel {
    let profileImageTitle: String
    var profileImage: UIImage? {
        return UIImage(named:profileImageTitle)
    }
    let writerName: String
    let contentsLabel: String
    let createdAtLabel: String
    let isLiked: Bool
    var heartImage: UIImage? {
        return isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart")
    }
    let heartCount: Int
    
}

// MARK: - Extensions
extension MumentCardBySongModel {
    static var myMumentSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15)
    ]
    
    static var allMumentsSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020", isLiked:false, heartCount:15)
    ]
}
