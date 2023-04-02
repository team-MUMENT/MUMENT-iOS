//
//  SearchResultResponseModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation

struct SearchResultResponseModelElement: Codable, Equatable {
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
    
    static func setSearchResultModelToUserDefaults(data: [SearchResultResponseModelElement], forKey: String) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: forKey)
            debugPrint("encoded", encoded)
        }
    }
    
    static func getSearchResultModelFromUserDefaults(forKey: String) -> [SearchResultResponseModelElement]? {
        if let savedData = UserDefaults.standard.object(forKey: forKey) as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([SearchResultResponseModelElement].self, from: savedData) {
                debugPrint("saved object", savedObject)
                return savedObject
            } else { return nil }
        } else {
            return nil
        }
    }
}

typealias SearchResultResponseModel = [SearchResultResponseModelElement]
