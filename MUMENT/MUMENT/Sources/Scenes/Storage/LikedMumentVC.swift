//
//  SecondVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/14.
//

import UIKit

class LikedMumentVC: UIViewController {
    
    var withouHeartMumentData: [GetLikedMumentResponseModel.Mument] = []
    
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
        
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setCVLayout()
        getLikedMumentStorage(userId: "62cd5d4383956edb45d7d0ef", filterTags: [])
    }
    
    // MARK: - Function
    private func setCollectionView() {
        self.likedMumentCV.register(ListCVC.self, forCellWithReuseIdentifier: ListCVC.className)
        self.likedMumentCV.register(AlbumCVC.self, forCellWithReuseIdentifier: AlbumCVC.className)
        self.likedMumentCV.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.className )
        
        likedMumentCV.delegate = self
        likedMumentCV.dataSource = self
    }
}

// MARK: - CollectionView UI
extension LikedMumentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return withouHeartMumentData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCVC.className, for: indexPath) as? ListCVC,
              let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCVC.className, for: indexPath) as? AlbumCVC
        else { return UICollectionViewCell() }
        
        switch cellCategory {
        case .listCell:
            debugPrint("indexPath.row",indexPath.row)
            listCell.setWithoutHeartCardUI()
            listCell.setWithoutHeartCardData(withouHeartMumentData[indexPath.row])
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
            let cellWidth = ((CVWidth - 40) - (5 * 3)) / 4
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch cellCategory {
        case .listCell:
            return 15
        case .albumCell:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: SectionHeader.className , for: indexPath)
                    as? SectionHeader else {
                return UICollectionReusableView()
            }
            return header
        }else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellCategory{
        case .listCell:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .albumCell:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
}

extension LikedMumentVC {
    private func setCVLayout() {
        view.addSubViews([likedMumentCV])
        
        likedMumentCV.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - Network
extension LikedMumentVC {
    private func getLikedMumentStorage(userId: String, filterTags: [Int]) {
        StorageAPI.shared.getLikedMumentStorage(userId: userId, filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetLikedMumentResponseModel {
                    self.withouHeartMumentData = result.muments
                    debugPrint("result값은 대입함",result)
                    self.likedMumentCV.reloadData()
                } else {
                    debugPrint("🚨당신 모델이 이상해열~🚨")
                }
            default:
                self.makeAlert(title: """
네트워크 오류로 인해 연결에 실패했어요! 😢
잠시 후에 다시 시도해 주세요.
""")
            }
        }
    }
}
