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
    
}

// MARK: - Extensions
extension MumentCardBySongModel {
    static var myMumentSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15)
    ]
    
    static var allMumentsSampleData: [MumentCardBySongModel] = [
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"못 어머니, 까닭이요, 노루, 쓸쓸함과 봅니다. 멀리 이름과, 내 하나에 잔디가 내린 계십니다. 겨울이 그리워 사람들의 경, 어머니, 내린 것은 파란 버리었습니다. 나는 별 계절이 많은 노루, 나의 위에도 이름을 무엇인지 듯합니다. 된 어머님, 아무 하나에 나의 이네들은 흙으로 옥 무성할 까닭입니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image1", writerName:"이수지", contents:"이웃 멀듯이, 이름과, 거외다. 피어나듯이 위에 불러 아이들의 쓸쓸함과 무엇인지 별 그리워 버리었습니다. 옥 쉬이 사랑과 시와 무성할 북간도에 별에도 버리었습니다. 밤을 사람들의 아이들의 이제 헤는 하나에 가난한 릴케 딴은 까닭입니다.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image3", writerName:"이수지", contents:"추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다. 쓸쓸함과 가득 아침이 된 이웃 딴은 있습니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image4", writerName:"이수지", contents:" 별 위에도 이름을 까닭이요, 거외다. 사랑과 파란 너무나 말 잔디가 릴케 봅니다. 없이 내일 이제 까닭입니다. 별 추억과 헤는 다 까닭이요, 가을로 듯합니다. 그러나 마디씩 속의 시인의 애기 것은 나는 있습니다. 가을로 어머니 시와 우는 이름과 강아지, 시인의 봅니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image5", writerName:"이수지", contents:" 패, 시인의 가을로 별 어머니 봅니다. 책상을 시인의 당신은 가을로 내일 가득 있습니다. 하나에 별 사람들의 까닭입니다. 한 우는 어머님, 별 언덕 봅니다. 추억과 차 이름과, 나는 남은 마리아 당신은 봅니다.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image6", writerName:"이수지", contents:"그러나 내린 어머님, 별 겨울이 딴은 듯합니다. 별들을 마리아 아무 묻힌 이름과, 피어나듯이 흙으로 멀리 버리었습니다. 이런 때 그러나 위에 버리었습니다. 나는 책상을 어머니, 계십니다. 벌레는 잔디가 불러 지나고 별이 불러 별 듯합니다. 별 청춘이 써 겨울이 그리워 가득 버리었습니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"노루, 별 별이 애기 계집애들의 봅니다. 나의 나는 다하지 헤는 까닭이요, 이름과, 가난한 버리었습니다. 무성할 위에 멀듯이, 소녀들의 밤이 나는 않은 속의 이 봅니다. 별 아스라히 비둘기, 내 봅니다. 때 쉬이 별 이름자를 이 없이 어머니, 듯합니다.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"부끄러운 이름과 무덤 딴은 아무 봅니다. 쓸쓸함과 무엇인지 경, 있습니다. 이름과, 했던 것은 불러 소녀들의 내일 봅니다. 무덤 무엇인지 이웃 오는 별 노루, 이름자를 벌레는 헤일 거외다. 이국 그리고 청춘이 언덕 계집애들의 북간도에 버리었습니다. ", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15),
        MumentCardBySongModel(profileImageTitle:"image2", writerName:"이수지", contents:"우는 어머니 멀듯이, 시와 자랑처럼 아이들의 별 무성할 계십니다. 남은 옥 했던 별이 패, 봄이 까닭입니다. 북간도에 애기 패, 가난한 별빛이 헤일 다 별 멀리 있습니다. 우는 이국 불러 하늘에는 하나에 겨울이 까닭입니다. 이네들은 별 시인의 했던 나의 별이 겨울이 프랑시스 있습니다.", createdAt:"1 Sep, 2020", isLiked:false, heartCount:15)
    ]
}
