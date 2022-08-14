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
        mumentAlbumView.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        debugPrint("좋아요한 뮤멘트 이미지 fetch")
    }
    
    func fetchData(_ cellData: GetMyMumentResponseModel.Mument) {
        mumentAlbumView.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
    }
    
    func setWithoutHeartCardUI() {
        self.addSubviews([withoutHeartCardView])
        withoutHeartCardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setWithoutHeartCardData(_ cellData: GetLikedMumentResponseModel.Mument) {
        withoutHeartCardView.setData(cellData)
    }
    
    func setEmptyCardView() {
        self.addSubviews([storageEmptyView])
        storageEmptyView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    func setDefaultCardData(_ cellData:GetMyMumentResponseModel.Mument) {
    //        defaultCardView.setData(defaultData[0])
        defaultCardView.setData(cellData)
    }
}


