//
//  MumentsByTagModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/14.
//

import UIKit

struct MumentsByTagModel {
    let title: String
    let artist: String
    let contents: String
    let profileImageName: String
    var profileImage: UIImage? {
        return UIImage(named:profileImageName)
    }
    let writerName:String
}

// MARK: - Extensions
extension MumentsByTagModel {
    static var sampleData: [MumentsByTagModel] = [
        MumentsByTagModel(title:"민수는 혼란스럽다", artist: "민수", contents: "옷을 되는 봄날의 실현에 싹이 꾸며 몸이 사막이다. 든 동력은 피가 그리하였는가? 그러므로 수 같은 오아이스도 우는 사막이다. 능히 것은 생생하며, 청춘에서만 우리의 방황하여도, 있는 위하여 귀는 이상 아니더면, 철환하였는가? 가지에 가치를 피가 위하여 우리의 때문이다.", profileImageName:"image3", writerName: "이수지"),
        MumentsByTagModel(title:"Antifreeze", artist: "백예린", contents: "어머니, 이네들은 거외다. 말 이름을 슬퍼하는 이웃 봅니다. 인생에 있는가?불어 얼음과 천자만홍이 풍부하게 역사를 이것이다. 이것은 풀이 대한 이것이다. 못하다 무한한 오직 날카로우나 청춘에서만 밝은 불어 고동을 같지 있다. 얼음이 바이며, 생생하며, 뿐이다. ", profileImageName:"image4", writerName: "이수지"),
        MumentsByTagModel(title:"하늘나라", artist: "혁오", contents: "인생을 따뜻한 귀는 예수는 피어나기 앞이 행복스럽고 아름다우냐? 갑 두손을 꾸며 구하지 산야에 위하여서. 사라지지 웅대한 속잎나고, 있으랴? 평화스러운 피어나는 것은 열매를 이상을 있다. 영원히 길지 것이 끓는다.", profileImageName:"image2", writerName: "이수지"),
        MumentsByTagModel(title:"덩", artist: "새소년", contents: "긴지라 모래뿐일 구하지 웅대한 산야에 얼마나 얼음이 피고, 이것이다. 간에 것은 위하여, 이상이 고행을 있음으로써 찾아다녀도, 든 있으랴? 현저하게 두손을 청춘을 아니다. 피부가 현저하게 대고, 때까지 미인을 눈에 속에서 인간의 바로 그리하였는가?", profileImageName:"image4", writerName: "이수지"),
        MumentsByTagModel(title:"빨간 맛", artist: "레드벨벳", contents: " 그들은 이 무엇을 피가 희망의 없는 기관과 있는가? 눈이 타오르고 굳세게 두기 그림자는 그리하였는가? 방황하여도, 불어 대고, 인류의 튼튼하며, 영원히 낙원을 피에 그들의 피다. 모래뿐일 위하여, 봄바람을 유소년에게서 인간의 보이는 사람은 말이다.", profileImageName:"image5", writerName: "이수지")
    ]
}

