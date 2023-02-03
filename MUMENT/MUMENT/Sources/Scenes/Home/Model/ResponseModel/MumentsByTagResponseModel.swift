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
        let id: Int
        let content: String
        let music: Music
        let createdAt: String
        let user: User

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case content = "content"
            case music = "music"
            case createdAt = "createdAt"
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
