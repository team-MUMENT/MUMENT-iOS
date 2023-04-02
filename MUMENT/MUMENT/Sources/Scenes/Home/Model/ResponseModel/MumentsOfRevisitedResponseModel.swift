//
//  MumentsOfRevisitedResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/22.
//

import Foundation

// MARK: - MumentsOfRevisitedResponseModel
struct MumentsOfRevisitedResponseModel: Codable {
    let againMument: [AgainMument]

    enum CodingKeys: String, CodingKey {
        case againMument = "againMument"
    }
    
    // MARK: - AgainMument
    struct AgainMument: Codable {
        let music: Music
        let user: User
        let mumentId: Int
        let content: String
        let createdAt: String

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case mumentId = "mumentId"
            case content = "content"
            case createdAt = "createdAt"
        }
        
        // MARK: - Music
        struct Music: Codable {
            let id: String
            let name: String
            let artist: String
            let image: String

            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case name = "name"
                case artist = "artist"
                case image = "image"
            }
        }

        // MARK: - User
        struct User: Codable {
            let id: Int
            let name: String
            let image: String?

            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case name = "name"
                case image = "image"
            }
        }
    }
}

