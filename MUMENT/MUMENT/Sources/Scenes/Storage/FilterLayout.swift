//
//  FilterLayout.swift
//  MUMENT
//
//  Created by 김담인 on 2023/01/22.
//

import UIKit

enum LayoutType {
    case impression, feel
}

final class FilterLayout: UICollectionViewCompositionalLayout {
        
    private var impressionCompositionalLayoutSection: NSCollectionLayoutSection = {
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(37))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let trailingInset = UIScreen.main.bounds.width - itemSize.widthDimension.dimension*3 - 20
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(37))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: trailingInset)
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [group, group])
        verticalGroup.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return section
    }()
    
    private var feelCompositionalLayoutSection: NSCollectionLayoutSection = {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(37))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(37))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [group, group, group, group, group])
        verticalGroup.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return section
    }()
        
    init(layoutType: LayoutType) {
        switch layoutType {
        case .impression:
            super .init(section: impressionCompositionalLayoutSection)
        case .feel:
            super .init(section: feelCompositionalLayoutSection)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
