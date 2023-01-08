//
//  StorageMumentVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/09.
//

import UIKit
import SnapKit
import Then

final class StorageMumentVC: BaseVC {
    
    // MARK: - Enum
    enum TabType {
        case myMument
        case likedMument
    }
    
    // MARK: - Components
    lazy var filterSectionView = FilterSectionView()
    private let tagSectionView = TagSectionView()
    private let storageMumentCV = StorageMumentCV()
    
    private var dateArray: [Int] = [1]
    private var dateDictionary : [Int : Int] = [:]
    private var numberOfSections = 0
    
    // MARK: - Properties
    private let storageBottomSheet = StorageBottomSheet()
    private var tagsViewHeightConstant = 0
    private var selectedTagsInt: [Int] = []
    private var cellCategory : CellCategory = .listCell {
        didSet {
            self.storageMumentCV.reloadData()
        }
    }
    /// StorageBottomSheet에서 전달 받은 태그 버튼 배열
    private var selectedTagButtons = [TagButton]() {
        didSet {
            if self.selectedTagButtons.count == 0 {
                filterSectionView.filterButton.isSelected = false
            }else {
                filterSectionView.filterButton.isSelected = true
            }
        }
    }
    private var emptyView = StorageEmptyView()
    private var storageMumentData: [StorageMumentModel] = []
    private var tabType: TabType = .myMument
    
    // MARK: - Initialization
    init(type: TabType) {
        super.init(nibName: nil, bundle: nil)
        self.tabType = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUILayout()
        setBottomSheet()
        setPressAction()
        setEmptyView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
        getLikedMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
    }
    
    // MARK: - Function.self
    private func setEmptyView() {
        switch tabType {
        case .myMument:
            self.emptyView.setMyMumentLayout()
        case .likedMument:
            self.emptyView.setLikedMumentLayout()
        }
    }
    
    private func setCollectionView() {
        self.storageMumentCV.register(ListCVC.self, forCellWithReuseIdentifier: ListCVC.className)
        self.storageMumentCV.register(AlbumCVC.self, forCellWithReuseIdentifier: AlbumCVC.className)
        self.storageMumentCV.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.className )
        
        storageMumentCV.delegate = self
        storageMumentCV.dataSource = self
    }
    
    func setTagsTitle(_ tagButtton:[TagButton]) {
        selectedTagsInt = []
        tagButtton.forEach {
            if let title = $0.titleLabel?.text {
                selectedTagsInt.append(title.tagInt() ?? 0)
            }
        }
        
        getMyMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
        getLikedMumentStorage(userId: UserInfo.shared.userId ?? "", filterTags: selectedTagsInt)
    }
    
    /// Set 으로 중복값 제거하기.self
    private func removeDuplication(in array: [Int]) -> [Int]{
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
    
    private func setDateDictionary() {
        var dates: [Int] = []
        var date = 0
        
        if storageMumentData.count != 0 {
            
            storageMumentData.forEach {
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
                storageMumentData.forEach {
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
    
    private func setPressAction() {
        filterSectionView.filterButton.press {
            self.storageBottomSheet.modalPresentationStyle = .overFullScreen
            self.present(self.storageBottomSheet, animated: false) {
                self.storageBottomSheet.showBottomSheetWithAnimation()
            }
        }
        filterSectionView.listButton.press { [self] in
            cellCategory = .listCell
        }
        filterSectionView.albumButton.press { [self] in
            cellCategory = .albumCell
        }
    }
}

// MARK: - Protocol
extension StorageMumentVC: storageBottomSheetDelegate {
    private func showSelectedTagsView() {
        if selectedTagButtons.count != 0 {
            self.tagsViewHeightConstant = 49
            self.tagSectionView.addTagButtonsToStackView(tagButtons: selectedTagButtons)
        }else {
            self.tagsViewHeightConstant = 0
        }
        
        tagSectionView.snp.updateConstraints {
            $0.height.equalTo(self.tagsViewHeightConstant)
        }
        
        tagSectionView.layoutIfNeeded()
        
        self.setTagsTitle(selectedTagButtons)
    }
    
    private func setBottomSheet() {
        storageBottomSheet.delegate = self
    }
    
    func sendButtonData(data: [TagButton]) {
        selectedTagButtons = data
        
        selectedTagButtons.forEach { button in
            button.press {
                var tempButtons = [TagButton]()
                
                self.selectedTagButtons.forEach { thisButton in
                    if thisButton != button {
                        tempButtons.append(thisButton)
                    }
                }
                self.selectedTagButtons = tempButtons
                self.tagSectionView.removeButtonsFromStackView()
                
                self.showSelectedTagsView()
            }
        }
        showSelectedTagsView()
    }
}

// MARK: - UICollectionViewDataSource
extension StorageMumentVC: UICollectionViewDataSource{
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
            
            switch tabType {
            case .myMument:
                listCell.setDefaultCardUI()
                if indexPath.section == 0 {
                    if indexPath.row > storageMumentData.count - 1{
                        listCell.setEmptyCardView()
                        storageMumentCV.reloadData()
                        return listCell
                    }
                    listCell.setDefaultCardData(storageMumentData[indexPath.row])
                    return listCell
                }
                var mData = 0
                for i in 0...indexPath.section-1{
                    mData += (dateDictionary[dateArray[i]])!
                }
                listCell.setDefaultCardData(storageMumentData[mData + indexPath.row])
                return listCell
                
            case .likedMument:
                if indexPath.section == 0 {
                    if indexPath.row > storageMumentData.count - 1{
                        listCell.setEmptyCardView()
                        storageMumentCV.reloadData()
                        return listCell
                    }
                    listCell.setWithoutHeartCardUI()
                    listCell.setWithoutHeartCardData(storageMumentData[indexPath.row])
                    return listCell
                }
                var mData = 0
                for i in 0...indexPath.section-1{
                    mData += (dateDictionary[dateArray[i]])!
                }
                listCell.setWithoutHeartCardUI()
                listCell.setWithoutHeartCardData(storageMumentData[mData + indexPath.row])
                return listCell
            }
            
        case .albumCell:
            if indexPath.section == 0 {
                if indexPath.row > storageMumentData.count - 1{
                    albumCell.setEmptyCardView()
                    storageMumentCV.reloadData()
                    return albumCell
                }
                albumCell.fetchData(storageMumentData[indexPath.row])
                return albumCell
            }
            var mData = 0
            for i in 0...indexPath.section-1{
                mData += (dateDictionary[dateArray[i]])!
            }
            albumCell.fetchData(storageMumentData[mData + indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: SectionHeader.className , for: indexPath)
                    as? SectionHeader else {
                return UICollectionReusableView()
            }
            if storageMumentData.count == 0 {
                header.resetHeader()
                
                emptyView.isHidden = false
                emptyView.writeButton.press {
                    self.tabBarController?.selectedIndex = 1
                }
                return header
            }
            emptyView.isHidden = true
            let year = dateArray[indexPath.section] / 100
            let month = dateArray[indexPath.section] - (100 * year)
            header.setHeader(year, month)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension StorageMumentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.mumentId = storageMumentData[indexPath.row].id
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StorageMumentVC: UICollectionViewDelegateFlowLayout {
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

// MARK: - UI
extension StorageMumentVC {
    private func setUILayout() {
        view.addSubViews([filterSectionView, tagSectionView, storageMumentCV, emptyView])
        
        filterSectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        tagSectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(filterSectionView.snp.bottom)
            $0.height.equalTo(self.tagsViewHeightConstant)
        }
        
        storageMumentCV.snp.makeConstraints{
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(tagSectionView.snp.bottom)
        }
        
        emptyView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(tagSectionView.snp.bottom)
        }
        
        emptyView.isHidden = true
    }
}

// MARK: - Network
extension StorageMumentVC {
    private func mapMyMumentData(data: [GetMyMumentResponseModel.Mument]) {
        self.storageMumentData = []
        self.storageMumentData = data.map {
            StorageMumentModel(id: $0.id, user: $0.user, music: $0.music, isFirst: $0.isFirst, impressionTag: $0.impressionTag, feelingTag: $0.feelingTag, cardTag: $0.cardTag, content: $0.content, isPrivate: $0.isPrivate, isLiked: $0.isLiked, createdAt: $0.createdAt, year: $0.year, month: $0.month, likeCount: $0.likeCount)
        }
    }
    
    private func mapLikedMumentData(data: [GetLikedMumentResponseModel.Mument]) {
        self.storageMumentData = []
        self.storageMumentData = data.map {
            StorageMumentModel(id: $0.id, user: $0.user, music: $0.music, isFirst: $0.isFirst, impressionTag: $0.impressionTag, feelingTag: $0.feelingTag, cardTag: $0.cardTag, content: $0.content, isPrivate: $0.isPrivate, isLiked: $0.isLiked, createdAt: $0.createdAt, year: $0.year, month: $0.month, likeCount: nil)
        }
    }
    
    private func getMyMumentStorage(userId: String, filterTags: [Int]) {
        StorageAPI.shared.getMyMumentStorage(userId: userId, filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetMyMumentResponseModel {
                    self.mapMyMumentData(data: result.muments)
                    self.setDateDictionary()
                    self.storageMumentCV.reloadData()
                } else {
                    debugPrint(MessageType.modelErrorForDebug.message)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func getLikedMumentStorage(userId: String, filterTags: [Int]) {
        StorageAPI.shared.getLikedMumentStorage(userId: userId, filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetLikedMumentResponseModel {
                    self.mapLikedMumentData(data: result.muments)
                    self.setDateDictionary()
                    self.storageMumentCV.reloadData()
                } else {
                    debugPrint(MessageType.modelErrorForDebug.message)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
