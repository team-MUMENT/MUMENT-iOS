//
//  PostMumentBodyModel.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/21.
//

import Foundation

// MARK: - PostMumentBodyModel
struct PostMumentBodyModel: Codable {
    var isFirst: Bool
    var impressionTag: [Int]
    var feelingTag: [Int]
    var content: String
    var isPrivate: Bool
    var musicId: String
    var musicArtist: String
    var musicImage: String
    var musicName: String
    
    init(isFirst: Bool, impressionTag: [Int], feelingTag: [Int], content: String, isPrivate: Bool, musicId: String, musicArtist: String, musicImage: String, musicName: String) {
        self.isFirst = isFirst
        self.impressionTag = impressionTag
        self.feelingTag = feelingTag
        self.content = content
        self.isPrivate = isPrivate
        self.musicId = musicId
        self.musicArtist = musicArtist
        self.musicImage = musicImage
        self.musicName = musicName
    }
    
    init() {
        self = PostMumentBodyModel(isFirst: false, impressionTag: [], feelingTag: [], content: "", isPrivate: false, musicId: "", musicArtist: "", musicImage: "", musicName: "")
    }
}
