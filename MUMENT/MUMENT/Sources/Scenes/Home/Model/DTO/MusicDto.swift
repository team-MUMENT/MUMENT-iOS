//
//  SongToMumentDto.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/30.
//

import Foundation

struct MusicDto {
//    var mumentId: String
    var musicId: String
    var musicTitle: String
    var artist: String
    var albumUrl: String
}

extension MusicDto {
    static var sampleData: [MusicDto] = [
        MusicDto(musicId: "1622167332", musicTitle: "Vancouver", artist: "Big Naughty", albumUrl: "https://avatars.githubusercontent.com/u/108561249?s=200&v=4")
    ]
}
