//
//  FirstVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/14.
//

import UIKit
import Foundation

class MyMumentVC: UIViewController {
    
    var defaultMumentData: [GetMyMumentResponseModel.Mument] = []
    var selectedTagsInt: [Int] = []
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
        
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    var dateArray: [Int] = [1]
    var dateDictionary : [Int : Int] = [:]
    var numberOfSections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUILayout()
        
        getMyMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
    }
    
    // MARK: - Function
    private func setCollectionView() {
        self.myMumentCV.register(ListCVC.self, forCellWithReuseIdentifier: ListCVC.className)
        self.myMumentCV.register(AlbumCVC.self, forCellWithReuseIdentifier: AlbumCVC.className)
        self.myMumentCV.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.className )
        
        myMumentCV.delegate = self
        myMumentCV.dataSource = self
    }
    
    func setTagsTitle(_ tagButtton:[TagButton]) {
        selectedTagsInt = []
        tagButtton.forEach {
            if let title = $0.titleLabel?.text {
                selectedTagsInt.append(title.tagInt() ?? 0)
                debugPrint("타이틀", title)
                debugPrint("프린트", title.tagInt() ?? 0)
            }
        }
        getMyMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
    }
    
    /// Set 으로 중복값 제거하기
    func removeDuplication(in array: [Int]) -> [Int]{
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
    
    func setDateDictionary() {
        var dates: [Int] = []
        var date = 0
        
        if defaultMumentData.count != 1 {
            
            defaultMumentData.forEach {
                date = $0.year * 100 + $0.month
                dates.append(date)
                dateDictionary[date] = 0
            }
            /// date 배열을 중복제거하고 dateArray에 대입
            dateArray = dates.uniqued()
            dateArray.sort(by: >)
            
            if dateArray.count == 0 {
                dateArray = [1]
            }
            
            for i in 0...dateArray.count-1 {
                defaultMumentData.forEach {
                    let mdate = $0.year * 100 + $0.month
                    /// 뮤멘트 데이터의 날짜가 미리 정렬해놓은 날짜 배열의 값과 일치 할때
                    if mdate == dateArray[i] {
                        dateDictionary[mdate]! += 1
                    }
                }
            }
            numberOfSections = dateArray.count
        } else {
            numberOfSections = 1
        }
    }
}

// MARK: - CollectionView UI
extension MyMumentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateDictionary[ self.dateArray[section] ] ?? 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCVC.className, for: indexPath) as? ListCVC,
              let albumCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AlbumCVC.className, for: indexPath) as? AlbumCVC
        else { return UICollectionViewCell() }
        
        switch cellCategory {
        case .listCell:
            listCell.setDefaultCardUI()
            
            if indexPath.section == 0 {
                listCell.setDefaultCardData(defaultMumentData[indexPath.row])
                return listCell
            }
            var mData = 0
            for i in 0...indexPath.section-1{
                mData += (dateDictionary[dateArray[i]])!
            }
            listCell.setDefaultCardData(defaultMumentData[mData + indexPath.row])
            return listCell
        case .albumCell:
            if indexPath.section == 0 {
                albumCell.fetchData(defaultMumentData[indexPath.row])
                return albumCell
            }
            var mData = 0
            for i in 0...indexPath.section-1{
                mData += (dateDictionary[dateArray[i]])!
            }
            albumCell.fetchData(defaultMumentData[mData + indexPath.row])
            return albumCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch cellCategory{
        case .listCell:
            return CGSize(width: 335.adjustedW, height: 216)
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
            let year = dateArray[indexPath.section] / 100
            let month = dateArray[indexPath.section] % 10
            header.setHeader(year, month)
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

extension MyMumentVC { 
    
    func setUILayout() {
        view.addSubViews([myMumentCV])
        myMumentCV.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
// MARK: - Network
extension MyMumentVC {
    private func getMyMumentStorage(userId: String, filterTags: [Int]) {
        StorageAPI.shared.getMyMumentStorage(userId: userId, filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetMyMumentResponseModel {
                    self.defaultMumentData = result.muments
                    self.setDateDictionary()
                    self.myMumentCV.reloadData()
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
