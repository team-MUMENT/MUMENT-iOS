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
    let contents: String
    let createdAt: String
    let isLiked: Bool
    var heartImage: UIImage? {
        return isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart")
    }
    let heartCount: Int
    let isFirst: Bool
    let impressionTags: [Int]
    let feelingTags: [Int]
    
}

// MARK: - Extensions
extension MumentCardBySongModel {
    static var myMumentSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image6", writerName:"이수지", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15, isFirst:true, impressionTags: [100,101], feelingTags:[])
    ]
    
    static var allMumentsSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"못 어머니, 까닭이요, 노루, 쓸쓸함과 봅니다. 멀리 이름과, 내 하나에 잔디가 내린 계십니다. 겨울이 그리워 사람들의 경, 어머니, 내린 것은 파란 버리었습니다. 나는 별 계절이 많은 노루, 나의 위에도 이름을 무엇인지 듯합니다. 된 어머님, 아무 하나에 나의 이네들은 흙으로 옥 무성할 까닭입니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15,isFirst:true, impressionTags: [103], feelingTags:[201]),
        MumentCardBySongModel(profileImageTitle:"image1", writerName:"이수지1", contents:"이웃 멀듯이, 이름과, 거외다. 피어나듯이 위에 불러 아이들의 쓸쓸함과 무엇인지 별 그리워 버리었습니다.", createdAt:"1 Sep, 2020", isLiked:true, heartCount:15,isFirst:true, impressionTags: [103,101], feelingTags:[]),
        MumentCardBySongModel(profileImageTitle:"image3", writerName:"이수지2", contents:"추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다. 쓸쓸함과 가득 아침이 된 이웃 딴은 있습니다. ", createdAt:"1 Sep, 2020", isLiked:true, heartCount:5,isFirst:true, impressionTags: [105,102], feelingTags:[204]),
        MumentCardBySongModel(profileImageTitle:"image4", writerName:"이수지3", contents:" 별 위에도 이름을 까닭이요, 거외다. 사랑과 파란 너무나 말 잔디가 릴케 봅니다. 없이 내일 이제 까닭입니다. 별 추억과 헤는 다 까닭이요, 가을로 듯합니다. 그러나 마디씩 속의 시인의 애기 것은 나는 있습니다. 가을로 어머니 시와 우는 이름과 강아지, 시인의 봅니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15,isFirst:true, impressionTags: [104,101], feelingTags:[]),
        MumentCardBySongModel(profileImageTitle:"image5", writerName:"이수지", contents:" 패, 시인의 가을로 별 어머니 봅니다. 책상을 시인의 당신은 가을로 내일 가득 있습니다.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:7,isFirst:true, impressionTags: [103,101], feelingTags:[205]),
        MumentCardBySongModel(profileImageTitle:"image6", writerName:"이수지4", contents:"그러나 내린 어머님, 별 겨울이 딴은 듯합니다. 별들을 마리아 아무 묻힌 이름과, 피어나듯이 흙으로 멀리 버리었습니다. 이런 때 그러나 위에 버리었습니다. 나는 책상을 어머니, 계십니다. 벌레는 잔디가 불러 지나고 별이 불러 별 듯합니다. 별 청춘이 써 겨울이 그리워 가득 버리었습니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15,isFirst:true, impressionTags: [103], feelingTags:[214,215]),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지5", contents:"", createdAt:"1 Sep, 2020", isLiked:true, heartCount:15,isFirst:true, impressionTags: [101], feelingTags:[206]),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"부끄러운 이름과 무덤 딴은 아무 봅니다. 쓸쓸함과 무엇인지 경, 있습니다. 이름과, 했던 것은 불러 소녀들의 내일 봅니다. 무덤 무엇인지 이웃 오는 별 노루, 이름자를 벌레는 헤일 거외다. 이국 그리고 청춘이 언덕 계집애들의 북간도에 버리었습니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:3,isFirst:false, impressionTags: [101], feelingTags:[203,208]),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"우는 어머니 멀듯이, 시와 자랑처럼 아이들의 별 무성할 계십니다. 남은 옥 했던 별이 패, 봄이 까닭입니다.", createdAt:"1 Sep, 2020", isLiked:true, heartCount:5,isFirst:true, impressionTags: [102,101], feelingTags:[])
    ]
}
