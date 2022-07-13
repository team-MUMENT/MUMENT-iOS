//
//  MumentsOfRevisitedModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit

struct MumentsOfRevisitedModel {
    let albumImageName: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageName)
    }
    let title: String
    let contents: String
    let profileImageName: String
    var profileImage: UIImage? {
        return UIImage(named:profileImageName)
    }
    let writerName:String
}

// MARK: - Extensions
extension MumentsOfRevisitedModel {
    static var sampleData: [MumentsOfRevisitedModel] = [
        MumentsOfRevisitedModel(albumImageName:"image5",title: "얼음과 가지에 그림자는 길지 꾸며 이것이다",contents: "내는 밥을 청춘의 인생을 용기가 그러므로 광야에서 만천하의 것이다.",profileImageName:"image3",writerName: "이수지"),
        MumentsOfRevisitedModel(albumImageName:"image2",title: "둘 불러 슬퍼하는 계절이 추억과 새워.",contents: "어머니, 이네들은 거외다. 말 이름을 슬퍼하는 이웃 봅니다",profileImageName:"image4",writerName: "이수지"),
        MumentsOfRevisitedModel(albumImageName:"image1",title: "L",contents: "볼 때마다 노래가 이렇게 사랑스러울 수 있 수 울 수",profileImageName:"image4",writerName: "이수지"),
        MumentsOfRevisitedModel(albumImageName:"image3",title: "별빛이 것은 불러 위에 듯합니다. ",contents: "내 책상을 노새, 풀이 별에도 써 언덕 있습니다. 아직 잔디가 말 봅니다. 벌레는 이름자를 릴케 아이들의 많은 하나 부끄러운 봅니다.",profileImageName:"image4",writerName: "이수지"),
        MumentsOfRevisitedModel(albumImageName:"image4",title: "별을 남은 다 걱정도 슬퍼하는 겨울이 이름을 별 소녀들의 까닭입니다.",contents: "덮어 아스라히 불러 별에도 이름과, 거외다.",profileImageName:"image4",writerName: "이수지")
    ]
}

