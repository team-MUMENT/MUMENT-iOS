//
//  SongDetailService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/20.
//
///////
import Alamofire

enum SongDetailService {
    case getSongInfo(musicData: MusicDTO)
    case getAllMuments(musicId: String, isOrderLiked: Bool, limit: Int, offset: Int)
}

extension SongDetailService: TargetType {
    
    var path: String {
        switch self {
        case .getSongInfo(musicData: let musicData):
            return "/music/\(musicData.id)"
        case .getAllMuments(musicId: let musicId, _, _, _):
            return "/music/\(musicId)/order"
        }
    }
    
    var method: HTTPMethod {
            return .get
    }
    
    var header: HeaderType {
        return .auth
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSongInfo(let musicData):
            return .requestBody([
                "musicId": musicData.id,
                "musicArtist": musicData.artist,
                "musicImage": musicData.albumUrl,
                "musicName": musicData.title
            ])
        case .getAllMuments(_, isOrderLiked: let isOrderLiked, limit: let limit, offset: let offset):
            return .query(["default": isOrderLiked ? "Y" : "N", "limit": limit, "offset": offset])
        }
    }
}
