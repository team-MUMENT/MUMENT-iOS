//
//  HomeCarouselResponseModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Foundation

// MARK: - CarouselResponseModel
struct CarouselResponseModel: Codable {
    let todayDate: String
    let bannerList: [BannerList]

    enum CodingKeys: String, CodingKey {
        case todayDate = "todayDate"
        case bannerList = "bannerList"
    }
    
    // MARK: - BannerList
    struct BannerList: Codable {
        let music: Music
        let tagTitle: String
        let displayDate: String

        enum CodingKeys: String, CodingKey {
            case music = "music"
            case tagTitle = "tagTitle"
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
                case name
                case artist
                case image
            }
        }
    }
}

