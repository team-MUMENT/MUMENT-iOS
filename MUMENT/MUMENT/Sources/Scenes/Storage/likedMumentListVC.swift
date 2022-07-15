//
//  SecondVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/14.
//

import UIKit

class likedMumentListVC: UIViewController {
    
    private let likedMumentListCV = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = .red
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setCVLayout()
    }
    
    // MARK: - Function
    private func setCollectionView() {
        self.likedMumentListCV.register(StorageCVC.self, forCellWithReuseIdentifier: StorageCVC.className)
        likedMumentListCV.delegate = self
        likedMumentListCV.dataSource = self
    }
}

// MARK: - CollectionView UI
extension likedMumentListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StorageCVC.className ,for: indexPath) as? StorageCVC
        else {
            return UICollectionViewCell()
        }
        cell.setData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension likedMumentListVC {
    private func setCVLayout() {
        view.addSubViews([likedMumentListCV])
        
        likedMumentListCV.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
