//
//  StorageCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/13.
//

import UIKit

final class ListCVC: UICollectionViewCell {
    
    // MARK: - Properties
   var withoutHeartData: [MumentCardWithoutHeartModel] = MumentCardWithoutHeartModel.sampleData
    
    let defaultCardView = DefaultMumentCardView()
    private let withoutHeartCardView = MumentCardWithoutHeartView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Function
    func setDefaultCardUI() {
        self.addSubviews([defaultCardView])
        defaultCardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setDefaultCardData(_ cellData: StorageMumentModel) {
        defaultCardView.setContentLayout(text: cellData.content)
        defaultCardView.setDefaultData(cellData)
    }
    
    func setWithoutHeartCardUI() {
        self.addSubviews([withoutHeartCardView])
        withoutHeartCardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setWithoutHeartCardData(_ cellData: StorageMumentModel) {
        withoutHeartCardView.setContentLayout(text: cellData.content)
        withoutHeartCardView.setWithoutHeartData(cellData)
    }
}

