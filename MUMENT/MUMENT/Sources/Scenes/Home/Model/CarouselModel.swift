//
//  m.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

struct CarouselModel {
    var color: UIColor
    let headerTitle: String
    let albumImageTitle: String
    var albumImage: UIImage? {
        return UIImage(named:albumImageTitle)
    }
    let songTitle: String
    let artistName:String
}

// MARK: - Extensions
extension CarouselModel {
    static var sampleData: [CarouselModel] = [
        CarouselModel(color: .purple, headerTitle:"신남 태그가 많이 남겨진 곡",albumImageTitle:"image1",songTitle: "San Francisco",artistName:"ADOY"),
        CarouselModel(color: .systemIndigo, headerTitle:"저녁 태그가 많이 남겨진 곡",albumImageTitle:"image2",songTitle: "MacBook Air", artistName:"Apple"),
        CarouselModel(color: .systemGreen, headerTitle:"비 태그가 많이 남겨진 곡",albumImageTitle:"image3",songTitle:"MacBook Pro",artistName:"orange")
    ]
}
