//
//  SongDetailInfoModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//
import UIKit

struct SongDetailInfoModel {
    let albumImageName: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageName)
    }
    let songtitle: String
    let artist: String
}

// MARK: - Extensions
extension SongDetailInfoModel {
    static var sampleData: [SongDetailInfoModel] = [
        SongDetailInfoModel(albumImageName:"image5", songtitle: "하늘나라", artist: "혁오")
    ]
}

