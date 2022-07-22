//
//  MumentsOfRevisitedResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/22.
//

import Foundation

// MARK: - MumentsOfRevisitedResponseModel
struct MumentsOfRevisitedResponseModel: Codable {
    let todayDate: String
    let againMument: [AgainMument]

    enum CodingKeys: String, CodingKey {
        case todayDate = "todayDate"
        case againMument = "againMument"
    }
    
    // MARK: - AgainMument
    struct AgainMument: Codable {
        let music: Music
        let user: User
        let id: String
        let mumentID: String
        let isFirst: Bool?
        let content: String
        let createdAt: String
        let displayDate: String

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case id = "_id"
            case mumentID = "mumentId"
            case isFirst = "isFirst"
            case content = "content"
            case createdAt = "createdAt"
            case displayDate = "displayDate"
        }
        
        // MARK: - Music
        struct Music: Codable {
            let id: String
            let name: String
            let artist: String
            let image: String?

            enum CodingKeys: String, CodingKey {
                case id = "_id"
                case name = "name"
                case artist = "artist"
                case image = "image"
            }
        }

        // MARK: - User
        struct User: Codable {
            let id: String
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

