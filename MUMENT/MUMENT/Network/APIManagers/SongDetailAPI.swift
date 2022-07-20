//
//  SongDetailAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//

import Foundation
import Alamofire

class SongDetailAPI: BaseAPI {
    static let shared = SongDetailAPI()
    
    private override init() { }
    
    /// [GET] 곡 정보, 내가 기록한 뮤멘트
    func getSongInfo(musicId: String, userId: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SongDetailService.getSongInfo(musicId: musicId, userId: userId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SongInfoResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 모든 뮤멘트
    func getAllMuments(musicId: String, userId: String, isOrderLiked: Bool,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SongDetailService.getAllMuments(musicId: musicId, userId: userId, isOrderLiked: isOrderLiked)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, AllMumentsResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

// MARK: - SongInfoResponseModel
struct SongInfoResponseModel: Codable {
    let music: UserClass
    let myMument: MyMument

    enum CodingKeys: String, CodingKey {
        case music = "music"
        case myMument = "myMument"
    }
    
    // MARK: - UserClass
    struct UserClass: Codable {
        let id: String
        let name: String
        let artist: String?
        let image: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case artist = "artist"
            case image = "image"
        }
    }

    // MARK: - MyMument
    struct MyMument: Codable {
        let music: PurpleMusic
        let user: UserClass
        let id: String
        let isFirst: Bool
        let impressionTag: [Int]
        let feelingTag: [Int]
        let content: String
        let isPrivate: Bool
        let likeCount: Int
        let isDeleted: Bool
        let createdAt: String
        let updatedAt: String
        let v: Int
        let cardTag: [Int]
        let date: String
        let isLiked: Bool

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case id = "_id"
            case isFirst = "isFirst"
            case impressionTag = "impressionTag"
            case feelingTag = "feelingTag"
            case content = "content"
            case isPrivate = "isPrivate"
            case likeCount = "likeCount"
            case isDeleted = "isDeleted"
            case createdAt = "createdAt"
            case updatedAt = "updatedAt"
            case v = "__v"
            case cardTag = "cardTag"
            case date = "date"
            case isLiked = "isLiked"
        }
    }

    // MARK: - PurpleMusic
    struct PurpleMusic: Codable {
        let id: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
        }
    }
}

// MARK: - AllMumentsResponseModel
struct AllMumentsResponseModel: Codable {
    let mumentList: [MumentList]

    enum CodingKeys: String, CodingKey {
        case mumentList = "mumentList"
    }
    // MARK: - MumentList
    struct MumentList: Codable {
        let music: Music
        let user: User
        let id: String
        let isFirst: Bool
        let impressionTag: [Int]
        let feelingTag: [Int]
        let content: String
        let isPrivate: Bool
        let likeCount: Int
        let isDeleted: Bool
        let createdAt: String
        let updatedAt: String
        let v: Int
        let cardTag: [Int]
        let date: String
        let isLiked: Bool

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case user = "user"
            case id = "_id"
            case isFirst = "isFirst"
            case impressionTag = "impressionTag"
            case feelingTag = "feelingTag"
            case content = "content"
            case isPrivate = "isPrivate"
            case likeCount = "likeCount"
            case isDeleted = "isDeleted"
            case createdAt = "createdAt"
            case updatedAt = "updatedAt"
            case v = "__v"
            case cardTag = "cardTag"
            case date = "date"
            case isLiked = "isLiked"
        }
    }

    // MARK: - Music
    struct Music: Codable {
        let id: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
        }
    }

    // MARK: - User
    struct User: Codable {
        let id: String
        let name: String
        let image: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name = "name"
            case image = "image"
        }
    }
}
