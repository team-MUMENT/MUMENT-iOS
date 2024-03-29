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
    private let storageMumentCV = StorageMumentCV()
    private var emptyView = StorageEmptyView()
    private let filteredEmptyView = StorageEmptyView().then {
        $0.setFilteredLayout()
    }
   
    private let selectedTagsCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mGray5
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 0
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.height = 35
        $0.setCollectionViewLayout(layout, animated: false)
    }
    
    // MARK: - Properties
    private let storageFilterVC = StorageFilterVC()
    private var selectedTagIndex: [Int] = []
    private var selectedTagsInt: [Int] = []
    private var selectedTagsCVHeight = 0
    /// storageFilterVC에서 전달 받은 태그 버튼 배열
    private var selectedTagData = [String]() {
        didSet {
            if selectedTagData.isEmpty {
                selectedTagsCVHeight = 0
                selectedTagsCV.snp.updateConstraints {
                    $0.height.equalTo(selectedTagsCVHeight)
                }
                filterSectionView.filterButton.isSelected = false
            }else {
                filterSectionView.filterButton.isSelected = true
            }
        }
    }
    private var dateArray: [Int] = [1]
    private var dateDictionary : [Int : Int] = [:]
    private var numberOfSections = 0
    private var cellCategory : CellCategory = .listCell {
        didSet {
            self.storageMumentCV.reloadData()
        }
    }
    private var storageMumentData: [StorageMumentModel] = [] {
        didSet {
            if storageMumentData.isEmpty && selectedTagData.isEmpty {
                filteredEmptyView.isHidden = true
                emptyView.isHidden = false
            }else if storageMumentData.isEmpty && !selectedTagData.isEmpty {
                filteredEmptyView.isHidden = false
                emptyView.isHidden = true
            }else {
                filteredEmptyView.isHidden = true
                emptyView.isHidden = true
            }
        }
    }
    private var tabType: TabType = .myMument
    private let viewForHeight = MumentCardWithoutHeartView()
    private var contentHeight: CGFloat = 0 
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
        storageFilterVCDelegate()
        setPressAction()
        setEmptyView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMumentDataWithTagInt(selectedTagsInt)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        storageMumentCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
    }
    
    // MARK: - Function
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
        
        self.selectedTagsCV.register(cell: SelectedTagCVC.self, forCellWithReuseIdentifier: SelectedTagCVC.className)
        self.selectedTagsCV.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.className )
        selectedTagsCV.dataSource = self
        selectedTagsCV.delegate = self
    }
    
    //TODO: TagInt 값 수정 필요
    private func changeToTagInt(_ tagData:[String]) {
        selectedTagsInt = []
        tagData.forEach {
            selectedTagsInt.append($0.tagInt() ?? 0)
        }
        
        getMumentDataWithTagInt(selectedTagsInt)
    }
    
    private func getMumentDataWithTagInt(_ selectedTagsInt: [Int]) {
        switch tabType {
        case .myMument:
            getMyMumentStorage(filterTags: selectedTagsInt)
        case .likedMument:
            getLikedMumentStorage(filterTags: selectedTagsInt)
        }
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
            
            for i in 0...dateArray.count - 1 {
                storageMumentData.forEach {
                    let mdate = $0.year * 100 + $0.month
                    /// 뮤멘트 데이터의 날짜가 미리 정렬해놓은 날짜 배열의 값과 일치 할때
                    if mdate == dateArray[i] {
                        guard let numOfMuments = dateDictionary[mdate] else { return }
                        dateDictionary[mdate] = numOfMuments + 1
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
            self.storageFilterVC.setAppliedTagData(tags: self.selectedTagData, tagIndex: self.selectedTagIndex)
            
            self.storageFilterVC.modalPresentationStyle = .overFullScreen
            self.present(self.storageFilterVC, animated: false) {
                self.storageFilterVC.showBottomSheetWithAnimation()
            }
        }
        filterSectionView.listButton.press { [self] in
            switch tabType {
            case .myMument:
                sendGAEvent(eventName: .use_grid_my_mument, parameterValue: .my_mument_list)
            case .likedMument:
                sendGAEvent(eventName: .use_grid_like_mument, parameterValue: .like_mument_list)
            }
            cellCategory = .listCell
        }
        filterSectionView.albumButton.press { [self] in
            switch tabType {
            case .myMument:
                sendGAEvent(eventName: .use_grid_my_mument, parameterValue: .my_mument_grid)
            case .likedMument:
                sendGAEvent(eventName: .use_grid_like_mument, parameterValue: .like_mument_grid)
            }
            cellCategory = .albumCell
        }
    }
}

// MARK: - Protocol
extension StorageMumentVC: storageFilterDelegate {
    private func storageFilterVCDelegate() {
        storageFilterVC.delegate = self
    }
    
    func sendTagData(data: [String], tagIndex: [Int]) {
        selectedTagData = data
        selectedTagIndex = tagIndex
        
        self.changeToTagInt(selectedTagData)
        
        if selectedTagData.count != 0 {
            self.selectedTagsCVHeight = 49
           
        }else {
            self.selectedTagsCVHeight = 0
        }

        selectedTagsCV.snp.updateConstraints {
            $0.height.equalTo(self.selectedTagsCVHeight)
        }
        self.selectedTagsCV.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension StorageMumentVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case selectedTagsCV:
            return selectedTagData.count
        case storageMumentCV:
            return dateDictionary[ self.dateArray[section] ] ?? 1
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView{
        case selectedTagsCV:
            return 1
        case storageMumentCV:
            return numberOfSections
        default:
            return 0
        }
    }
    // MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
      
        case selectedTagsCV:
            let selectedTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedTagCVC.className, for: indexPath) as! SelectedTagCVC
            selectedTagCell.setTagButtonTitle(selectedTagData[indexPath.row])
            return selectedTagCell
            
        case storageMumentCV:
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
                    if indexPath.section == 0 && storageMumentData.isEmpty {
                        return listCell
                    }
                    var mData = 0
                    if indexPath.section != 0 {
                        for i in 0...indexPath.section - 1 {
                            if let numOfMuments = dateDictionary[dateArray[i]] {
                                mData += numOfMuments
                            }
                        }
                    }
                    listCell.setDefaultCardData(storageMumentData[mData + indexPath.row])
                    
                    listCell.defaultCardView.heartButton.removeTarget(nil, action: nil, for: .allTouchEvents)
                    listCell.defaultCardView.heartButton.press { [weak self] in
                        if let isLiked = self?.storageMumentData[indexPath.row].isLiked {
                            if isLiked {
                                self?.requestDeleteHeartLiked(mumentId: self?.storageMumentData[indexPath.row].id ?? 0, completion: { result in
                                    
                                    self?.storageMumentData[indexPath.row].isLiked = false
                                    self?.storageMumentData[indexPath.row].likeCount = result.likeCount
                                    
                                    guard let targetCell = collectionView.cellForItem(at: indexPath) as? ListCVC else { return }
                                    targetCell.defaultCardView.heartButton.setIsSelected(false)
                                    
                                    listCell.defaultCardView.isLiked = false
                                    listCell.defaultCardView.heartCount = result.likeCount
                                })
                            } else {
                                self?.requestPostHeartLiked(mumentId: self?.storageMumentData[indexPath.row].id ?? 0, completion: { result in
                                    
                                    self?.storageMumentData[indexPath.row].isLiked = true
                                    self?.storageMumentData[indexPath.row].likeCount = result.likeCount
                                    
                                    guard let targetCell = collectionView.cellForItem(at: indexPath) as? ListCVC else { return }
                                    targetCell.defaultCardView.heartButton.setIsSelected(true)
                                    
                                    listCell.defaultCardView.isLiked = true
                                    listCell.defaultCardView.heartCount = result.likeCount
                                    
                                })
                            }
                        }
                    }
                    return listCell
                case .likedMument:
                    listCell.setWithoutHeartCardUI()
                    if indexPath.section == 0 {
                        if storageMumentData.isEmpty {
                            return listCell
                        }
                        listCell.setWithoutHeartCardData(storageMumentData[indexPath.row])
                        return listCell
                    }
                    var mData = 0
                    for i in 0...indexPath.section - 1 {
                        mData += (dateDictionary[dateArray[i]])!
                    }
                    listCell.setWithoutHeartCardData(storageMumentData[mData + indexPath.row])
                    return listCell
                }
                
            case .albumCell:
                if indexPath.section == 0 {
                    if storageMumentData.isEmpty {
                        return albumCell
                    }
                    albumCell.fetchData(storageMumentData[indexPath.row])
                    return albumCell
                }
                var mData = 0
                for i in 0...indexPath.section - 1 {
                    if let numOfMuments = dateDictionary[dateArray[i]] {
                        mData += numOfMuments
                    }
                }
                albumCell.fetchData(storageMumentData[mData + indexPath.row])
                return albumCell
            }
        default: return UICollectionViewCell()
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
                return header
            }
            let year = dateArray[indexPath.section] / 100
            let month = dateArray[indexPath.section] - (100 * year)
            header.setHeader(year, month)
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate
extension StorageMumentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case selectedTagsCV:
            selectedTagData.remove(at: indexPath.row)
            selectedTagIndex.remove(at: indexPath.row)
            changeToTagInt(selectedTagData)
            selectedTagsCV.reloadData()
            storageMumentCV.reloadData()
        case storageMumentCV:
            var mData = 0
            if indexPath.section != 0 {
                for i in 0...indexPath.section - 1 {
                    if let numOfMuments = dateDictionary[dateArray[i]] {
                        mData += numOfMuments
                    }
                }
            }
            let mumentData = storageMumentData[mData + indexPath.row]
            let mumentID = mumentData.id
            let musicData = MusicDTO(id: mumentData.music.id,
                                 title: mumentData.music.name,
                                 artist: mumentData.music.artist,
                                 albumUrl: mumentData.music.image)
            let mumentDetailVC = MumentDetailVC()
            mumentDetailVC.setData(mumentId: mumentID, musicData: musicData)
            self.navigationController?.pushViewController(mumentDetailVC, animated: true) {
                switch self.tabType {
                case .myMument:
                    sendGAEvent(eventName: .mument_detail_page, parameterValue: .from_storage_my_mument)
                case .likedMument:
                    sendGAEvent(eventName: .mument_detail_page, parameterValue: .from_storage_like_mument)
                }
            }
        default: break
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StorageMumentVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case selectedTagsCV:
            return CGSize(width: selectedTagData[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.mumentB2B14]).width + 45, height: 35)
        case storageMumentCV:
            switch cellCategory{
            case .listCell:
                if storageMumentData.isEmpty {
                    return .zero
                }
                var mData = 0
                if indexPath.section != 0 {
                    for i in 0...indexPath.section - 1 {
                        if let numOfMuments = dateDictionary[dateArray[i]] {
                            mData += numOfMuments
                        }
                    }
                }
                let content = storageMumentData[mData + indexPath.item].content ?? ""
                if content == "" {
                    self.contentHeight = 165
                }else {
                    contentHeight = viewForHeight.getContentSize(content: content).height + 184
                }
                return CGSize(width: 335.adjustedW, height: self.contentHeight)
            case .albumCell:
                let CVWidth = collectionView.frame.width
                let cellWidth = ((CVWidth - 40) - (5 * 3)) / 4
                return CGSize(width: cellWidth, height: cellWidth)
            }
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView{
        case selectedTagsCV:
            return 10
        case storageMumentCV:
            switch cellCategory {
            case .listCell:
                return 15
            case .albumCell:
                return 5
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case selectedTagsCV:
            return 10
        case storageMumentCV:
            return 0
        default: return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch collectionView{
        case selectedTagsCV:
            return .zero
        case storageMumentCV:
            if section == 0 {
                return CGSize(width: view.frame.size.width, height: 47.adjustedH)
            }
            return CGSize(width: view.frame.size.width, height: 87.adjustedH)
        default:
            return .zero
        }
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
        view.addSubViews([filterSectionView, selectedTagsCV, storageMumentCV, emptyView, filteredEmptyView])
        
        filterSectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        selectedTagsCV.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(filterSectionView.snp.bottom)
            $0.height.equalTo(self.selectedTagsCVHeight)
        }
        
        storageMumentCV.snp.makeConstraints{
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(selectedTagsCV.snp.bottom)
        }
        
        emptyView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(selectedTagsCV.snp.bottom)
        }
        
        filteredEmptyView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(selectedTagsCV.snp.bottom)
        }
        
        emptyView.isHidden = true
        filteredEmptyView.isHidden = true
    }
}

// MARK: - Network
extension StorageMumentVC {
    private func mapMyMumentData(data: [GetMyMumentResponseModel.Mument]) {
        self.storageMumentData = []
        self.storageMumentData = data.map {
            StorageMumentModel(id: $0.id, user: $0.user, music: $0.music, isFirst: $0.isFirst, allCardTag: $0.allCardTag, cardTag: $0.cardTag, content: $0.content, isPrivate: $0.isPrivate, isLiked: $0.isLiked, createdAt: $0.createdAt, year: $0.year, month: $0.month, likeCount: $0.likeCount)
        }
    }
    
    private func mapLikedMumentData(data: [GetLikedMumentResponseModel.Mument]) {
        self.storageMumentData = []
        self.storageMumentData = data.map {
            StorageMumentModel(id: $0.id, user: $0.user, music: $0.music, isFirst: $0.isFirst, allCardTag: $0.allCardTag, cardTag: $0.cardTag, content: $0.content, isPrivate: $0.isPrivate, isLiked: $0.isLiked, createdAt: $0.createdAt, year: $0.year, month: $0.month, likeCount: $0.likeCount)
        }
    }
    
    private func getMyMumentStorage(filterTags: [Int]) {
        self.startActivityIndicator()
        StorageAPI.shared.getMyMumentStorage(filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetMyMumentResponseModel {
                    self.mapMyMumentData(data: result.muments)
                    self.setDateDictionary()
                    self.storageMumentCV.reloadData()
                } else {
                    debugPrint(MessageType.modelErrorForDebug.message)
                }
                self.stopActivityIndicator()
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func getLikedMumentStorage(filterTags: [Int]) {
        self.startActivityIndicator()
        StorageAPI.shared.getLikedMumentStorage(filterTags: filterTags) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetLikedMumentResponseModel {
                    self.mapLikedMumentData(data: result.muments)
                    self.setDateDictionary()
                    self.storageMumentCV.reloadData()
                } else {
                    debugPrint(MessageType.modelErrorForDebug.message)
                }
                self.stopActivityIndicator()
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
