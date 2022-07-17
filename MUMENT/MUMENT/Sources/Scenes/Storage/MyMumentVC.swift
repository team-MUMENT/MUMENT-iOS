//
//  FirstVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/14.
//

import UIKit

class MyMumentVC: UIViewController {
    
    var cellCategory : CellCategory = .listCell {
        didSet {
            self.myMumentCV.reloadData()
        }
    }
    
    private let myMumentCV = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = .green
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setCVLayout()
    }
    
    // MARK: - Function
    private func setCollectionView() {
        self.myMumentCV.register(ListCVC.self, forCellWithReuseIdentifier: ListCVC.className)
        self.myMumentCV.register(AlbumCVC.self, forCellWithReuseIdentifier: AlbumCVC.className)
        
        myMumentCV.delegate = self
        myMumentCV.dataSource = self
    }
}

// MARK: - CollectionView UI
extension MyMumentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
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
        return cellCategory.cellSize
    }
}

extension MyMumentVC {
    private func setCVLayout() {
        view.addSubViews([myMumentCV])
        
        myMumentCV.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
