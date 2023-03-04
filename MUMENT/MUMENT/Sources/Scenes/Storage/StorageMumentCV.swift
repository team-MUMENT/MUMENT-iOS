//
//  StorageMumentCV.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/08.
//

import UIKit
import Then

final class StorageMumentCV: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.backgroundColor = .clear
        self.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewLayout = layout
    }
}
