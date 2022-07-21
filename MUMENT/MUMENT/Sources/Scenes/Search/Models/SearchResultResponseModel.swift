//
//  SearchResultResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

struct SearchResultResponseModelElement: Codable {
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

typealias SearchResultResponseModel = [SearchResultResponseModelElement]
