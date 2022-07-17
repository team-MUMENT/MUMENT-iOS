//
//  StorageCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/13.
//

import UIKit

class ListCVC: UICollectionViewCell {
    
    // MARK: - Properties
    var defaultData: [DefaultMumentCardModel] = DefaultMumentCardModel.sampleData
    var withoutHeartData: [MumentCardWithoutHeartModel] = MumentCardWithoutHeartModel.sampleData
    
    private let defaultCardView = DefaultMumentCardView()
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
    
    func setDefaultCardData() {
        defaultCardView.setData(defaultData[0])
    }
    
    
    func setWithoutHeartCardUI() {
        self.addSubviews([withoutHeartCardView])
        withoutHeartCardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setWithoutHeartCardData() {
        withoutHeartCardView.setData(withoutHeartData[0])
    }
}

