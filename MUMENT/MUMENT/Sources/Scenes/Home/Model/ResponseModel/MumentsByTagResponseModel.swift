//
//  MumentByTagResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/22.
//

import Foundation

struct MumentsByTagResponseModel: Codable {
    let title: String
    let mumentList: [MumentList]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case mumentList = "mumentList"
    }
    
    // MARK: - MumentList
    struct MumentList: Codable {
        let id: String
        let content: String
        let impressionTag: [Int]
        let music: Music
        let createdAt: String
        let feelingTag: [Int]
        let user: User

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case content = "content"
            case impressionTag = "impressionTag"
            case music = "music"
            case createdAt = "createdAt"
            case feelingTag = "feelingTag"
            case user = "user"
        }
        
        // MARK: - Music
        struct Music: Codable {
            let name: String
            let artist: String

            enum CodingKeys: String, CodingKey {
                case name = "name"
                case artist = "artist"
            }
        }

        // MARK: - User
        struct User: Codable {
            let name: String
            let image: String?

            enum CodingKeys: String, CodingKey {
                case name = "name"
                case image = "image"
            }
        }
    }
}
