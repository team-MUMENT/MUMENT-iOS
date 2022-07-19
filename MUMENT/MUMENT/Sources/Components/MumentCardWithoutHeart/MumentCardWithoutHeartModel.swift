//
//  DefaultMumentModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit

struct MumentCardWithoutHeartModel {
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
    let contentsLabel: String
    let createdAtLabel: String
}

// MARK: - Extensions
extension MumentCardWithoutHeartModel {
    static var sampleData: [MumentCardWithoutHeartModel] = [
        MumentCardWithoutHeartModel(profileImageTitle:"image1", writerName:"이수지2", albumImageTitle: "image4", isFirst:false, impressionTags: [103], feelingTags:[208], songTitle:"Antifreeze", artistName: "백예린", contentsLabel:"음악은 저에게 영감을 줘요, 이 곡 추천해준 이부장에게 심심한 감사의 인사를 음악은 저에게 영감을 줘요.", createdAtLabel:"1 Sep, 2020"),
        MumentCardWithoutHeartModel(profileImageTitle:"image2", writerName:"이수지2", albumImageTitle: "image4", isFirst:true, impressionTags: [102], feelingTags:[210], songTitle:"Antifreeze", artistName: "백예린", contentsLabel:"부끄러운 이름과 무덤 딴은 아무 봅니다. 쓸쓸함과 무엇인지 경, 있습니다. ", createdAtLabel:"1 Sep, 2020"),
        MumentCardWithoutHeartModel(profileImageTitle:"image3", writerName:"이수지3", albumImageTitle: "image4", isFirst:false, impressionTags: [101], feelingTags:[214], songTitle:"Antifreeze", artistName: "백예린", contentsLabel:"그러나 내린 어머님, 별 겨울이 딴은 듯합니다. 별들을 마리아 아무 묻힌 이름과, 피어나듯이 흙으로 멀리 버리었습니다. 이런 때 그러나 위에 버리었습니다. 나는 책상을 어머니, 계십니다. 벌레는 잔디가 불러 지나고 별이 불러 별 듯합니다. 별 청춘이 써 겨울이 그리워 가득 버리었습니다.", createdAtLabel:"1 Sep, 2020"),
        MumentCardWithoutHeartModel(profileImageTitle:"image4", writerName:"이수지4", albumImageTitle: "image4", isFirst:true, impressionTags: [105], feelingTags:[202], songTitle:"Antifreeze", artistName: "백예린", contentsLabel:"", createdAtLabel:"1 Sep, 2020"),
        MumentCardWithoutHeartModel(profileImageTitle:"image5", writerName:"이수지5", albumImageTitle: "image4", isFirst:true, impressionTags: [104], feelingTags:[203], songTitle:"Antifreeze", artistName: "백예린", contentsLabel:"남은 옥 패, 이 너무나 이름을 그리워 나의 가난한 봅니다. 이름과 무덤 이름자 너무나 없이 봄이 밤이 까닭입니다. 차 부끄러운 때 오면 가을로 봅니다. 딴은 나의 내 하나 둘 있습니다. 하나 릴케 별 프랑시스 이국 봅니다. 가득 한 잔디가 부끄러운 봅니다. 까닭이요, 불러 애기 있습니다. ", createdAtLabel:"1 Sep, 2020")
    ]
}
