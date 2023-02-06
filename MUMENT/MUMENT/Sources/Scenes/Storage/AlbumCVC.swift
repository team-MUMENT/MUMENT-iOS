//
//  AlbumCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/16.
//

import UIKit

final class AlbumCVC: UICollectionViewCell {
    // MARK: - Properties
    let mumentAlbumView = UIImageView()
    
    private let defaultCardView = DefaultMumentCardView()
    private let withoutHeartCardView = MumentCardWithoutHeartView()
    private let storageEmptyView = StorageEmptyView()
    
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
        mumentAlbumView.setImageUrl(cellData.music.image)
    }
    
    func fetchData(_ cellData: StorageMumentModel) {
        mumentAlbumView.setImageUrl(cellData.music.image)
    }
    
    func setWithoutHeartCardUI() {
        self.addSubviews([withoutHeartCardView])
        withoutHeartCardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setWithoutHeartCardData(_ cellData: StorageMumentModel) {
        withoutHeartCardView.setWithoutHeartData(cellData)
    }
    
    func setEmptyCardView() {
        self.addSubviews([storageEmptyView])
        storageEmptyView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    func setDefaultCardData(_ cellData: StorageMumentModel) {
        defaultCardView.setDefaultData(cellData)
    }
}


