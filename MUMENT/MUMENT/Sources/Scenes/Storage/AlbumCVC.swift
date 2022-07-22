//
//  AlbumCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/16.
//

import UIKit

class AlbumCVC: UICollectionViewCell {
    // MARK: - Properties
    var dataSource: [DefaultMumentCardModel] = DefaultMumentCardModel.sampleData

    let mumentAlbumView = UIImageView()
    
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Function
    private func setUI() {
        self.addSubviews([mumentAlbumView])
        
        mumentAlbumView.snp.makeConstraints{
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func fetchData(_ cellData: GetLikedMumentResponseModel.Mument) {
        mumentAlbumView.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
    }
    
    func fetchData(_ cellData: GetMyMumentResponseModel.Mument) {
        mumentAlbumView.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
    }
}
