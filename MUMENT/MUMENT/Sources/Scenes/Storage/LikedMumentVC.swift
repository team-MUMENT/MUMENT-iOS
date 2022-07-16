//
//  SecondVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/14.
//

import UIKit

class LikedMumentVC: UIViewController {
    
    var cellCategory : CellCategory = .listCell {
        didSet {
            self.likedMumentCV.reloadData()
        }
    }
    
    private let likedMumentCV = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = .red
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
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
        self.likedMumentCV.register(ListCVC.self, forCellWithReuseIdentifier: ListCVC.className)
        self.likedMumentCV.register(AlbumCVC.self, forCellWithReuseIdentifier: AlbumCVC.className)
        
        likedMumentCV.delegate = self
        likedMumentCV.dataSource = self
    }
}

// MARK: - CollectionView UI
extension LikedMumentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCVC.className, for: indexPath) as? ListCVC,
              let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCVC.className, for: indexPath) as? AlbumCVC
        else { return UICollectionViewCell() }

        switch cellCategory {
        case .listCell:
            return listCell
        case .albumCell:
            return albumCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        switch cellCategory{
        case .listCell:
            return CGSize(width: 335, height: 216)
        case .albumCell:
            let CVWidth = collectionView.frame.width
            let cellWidth = ((CVWidth) - (5 * 3)) / 4
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
}

extension LikedMumentVC {
    private func setCVLayout() {
        view.addSubViews([likedMumentCV])
        
        likedMumentCV.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
    }
}
