//
//  MumentDetailResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - MumentDetailResponseModel
struct MumentDetailResponseModel: Codable {
    let isFirst: Bool
    let content: String?
    let impressionTag: [Int]
    let isLiked: Bool
    let count: Int
//    let music: Music
    let likeCount: Int
    let createdAt: String
    let feelingTag: [Int]
    let user: User
//    let isPrivate: Bool = false

    enum CodingKeys: String, CodingKey {
        case isFirst
        case content
        case impressionTag
        case isLiked
        case count
//        case music = "music"
        case likeCount
        case createdAt
        case feelingTag
        case user
//        case isPrivate = "isPrivate"
    }
    
    // MARK: - Music
//    struct Music: Codable {
//        let id: String
//        let name: String
//        let image: String?
//        let artist: String
//
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case name = "name"
//            case image = "image"
//            case artist = "artist"
//        }
//    }

    // MARK: - User
    struct User: Codable {
        let id: Int
        let image: String?
        let name: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case image
            case name
        }
    }

}

extension MumentDetailResponseModel {
    static var sampleData: [MumentDetailResponseModel] = [
        MumentDetailResponseModel(isFirst: true, content: "추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다. 쓸쓸함과 가득 아침이 된 이웃 딴은 있습니다. 이름을 별 보고, 쓸쓸함과 벌써 버리었습니다. 언덕 나는 아무 하나에 말 위에 둘 별 듯합니다. 별 위에도 이름을 까닭이요, 거외다. 사랑과 파란 너무나 말 잔디가 릴케 봅니다. 없이 내일 이제 까닭입니다. 별 추억과 헤는 다 까닭이요, 가을로 듯합니다. 그러나 마디씩 속의 시인의 애기 것은 나는 있습니다. 가을로 어머니 시와 우는 이름과 강아지, 시인의 봅니다. 패, 시인의 가을로 별 어머니 봅니다. 책상을 시인의 당신은 가을로 내일 가득 있습니다. 하나에 별 사람들의 까닭입니다. 한 우는 어머님, 별 언덕 봅니다. 추억과 차 이름과, 나는 남은 마리아 당신은 봅니다.", impressionTag: [100,101], isLiked: true, count: 5, likeCount: 15, createdAt: "1 Sep, 2020", feelingTag: [201], user: User(id: 40, image: "https://avatars.githubusercontent.com/u/108561249?s=200&v=4", name: "이수지"))
    ]
}
