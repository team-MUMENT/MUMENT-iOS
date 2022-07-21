//
//  MumentDetailVCModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//
import UIKit

struct MumentDetailVCModel {
    let profileImageName:String
    var profileImage: UIImage? {
        return UIImage(named:profileImageName)
    }
    let writerName:String
    let albumImageName: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageName)
    }
    let isFirst: Bool
    let impressionTags: [Int]
    let feelingTags: [Int]
    let songtitle: String
    let artist: String
    let contents:String
    let createdAt:String
    let isLiked: Bool
    var heartImage: UIImage? {
        return isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart")
    }
    let heartCount: Int
    let mumentCount: Int
}

// MARK: - Extensions
extension MumentDetailVCModel {
    static var sampleData: [MumentDetailVCModel] = [
        MumentDetailVCModel(profileImageName:"image5", writerName: "이수지", albumImageName: "image4", isFirst:true, impressionTags: [100,101], feelingTags:[], songtitle:"하늘나라",artist:"혁오",contents:"추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다. 쓸쓸함과 가득 아침이 된 이웃 딴은 있습니다. 이름을 별 보고, 쓸쓸함과 벌써 버리었습니다. 언덕 나는 아무 하나에 말 위에 둘 별 듯합니다. 별 위에도 이름을 까닭이요, 거외다. 사랑과 파란 너무나 말 잔디가 릴케 봅니다. 없이 내일 이제 까닭입니다. 별 추억과 헤는 다 까닭이요, 가을로 듯합니다. 그러나 마디씩 속의 시인의 애기 것은 나는 있습니다. 가을로 어머니 시와 우는 이름과 강아지, 시인의 봅니다. 패, 시인의 가을로 별 어머니 봅니다. 책상을 시인의 당신은 가을로 내일 가득 있습니다. 하나에 별 사람들의 까닭입니다. 한 우는 어머님, 별 언덕 봅니다. 추억과 차 이름과, 나는 남은 마리아 당신은 봅니다.",createdAt:"1 Sep, 2020",isLiked:true,heartCount:15,mumentCount:5)
    ]
}

