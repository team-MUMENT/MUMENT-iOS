//
//  SongDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//
//////
import UIKit
import SnapKit
import Then

final class SongDetailVC: BaseVC {
    
    // MARK: - Properties
    private let navigationBarView = DefaultNavigationBar()
    private let mumentTV = UITableView( frame: CGRect.zero, style: .grouped)
    
    var myMumentDataSource: [MumentCardBySongModel] = MumentCardBySongModel.myMumentSampleData
    var allMumentsDataSource: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData
    var myMumentData: SongInfoResponseModel.MyMument? = nil
    
    private var userId: Int = 0
    var musicData: MusicDTO = MusicDTO(id: "", title: "", artist: "", albumUrl: "")
    
    var allMumentsData: [AllMumentsResponseModel.MumentList] = []
    private var newAllMumentDataCount: Int = 0
    private var filterFlag: Bool = true
    private var fetchMoreFlag: Bool = true
    
    private var pageLimit: Int = 10
    private var pageOffset: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
        setButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetSongInfo()
        requestGetAllMuments(isOrderLiked: true, limit: 10, offset: 0)
    }
    
    // MARK: - Functions
    private func setTV() {
        mumentTV.delegate = self
        mumentTV.dataSource = self
        mumentTV.backgroundColor = .mBgwhite
        mumentTV.register(cell: SongInfoTVC.self, forCellReuseIdentifier: SongInfoTVC.className)
        mumentTV.register(cell: MumentCardBySongTVC.self, forCellReuseIdentifier: MumentCardBySongTVC.className)
        mumentTV.register(MyMumentSectionHeader.self, forHeaderFooterViewReuseIdentifier: MyMumentSectionHeader.className)
        mumentTV.register(AllMumentsSectionHeader.self, forHeaderFooterViewReuseIdentifier: AllMumentsSectionHeader.className)
        mumentTV.register(cell: SongDetailMyMumentEmptyTVC.self, forCellReuseIdentifier: SongDetailMyMumentEmptyTVC.className)
        mumentTV.register(cell: AllMumentEmptyTVC.self, forCellReuseIdentifier: AllMumentEmptyTVC.className)
        mumentTV.separatorStyle = .none
        mumentTV.showsVerticalScrollIndicator = false
    }
    
    private func setButtonActions(){
        navigationBarView.backButton.press{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setDetailData(userId: Int, musicId: String) {
        self.userId = userId
        self.musicData.id = musicId
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.setData(mumentId: self.myMumentData?.id ?? 0, musicData: musicData)
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
    
    @objc func didTapAllMumentView(_ sender: CardTapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        let index: Int = sender.index
        mumentDetailVC.setData(mumentId: self.allMumentsData[index].id, musicData: musicData)
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
}

// MARK: - UI
extension SongDetailVC {
    
    private func setLayout() {
        if #available(iOS 15, *) {
            mumentTV.sectionHeaderTopPadding = 0
        }
        
        mumentTV.tableFooterView = UIView(frame: .zero)
        mumentTV.sectionFooterHeight = 0
        
        view.addSubviews([navigationBarView,mumentTV])
        
        navigationBarView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        mumentTV.snp.makeConstraints{
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

// MARK: - UITableViewDataSource
extension SongDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let nums = allMumentsData.count == 0 ? 2 : 3
        return nums
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return 1
        case 1 :
            return 1
        case 2:
            return allMumentsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongInfoTVC.className, for: indexPath) as? SongInfoTVC else {
                return UITableViewCell()
            }
            cell.setData(musicData)
            return cell
        case 1:
            if allMumentsData.count == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllMumentEmptyTVC.className, for: indexPath) as? AllMumentEmptyTVC
                else { return UITableViewCell() }
                return cell
            }
            if myMumentData == nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SongDetailMyMumentEmptyTVC.className, for: indexPath) as? SongDetailMyMumentEmptyTVC
                else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                    return UITableViewCell()
                }
                cell.setData(myMumentData!)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
                cell.mumentCard.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.mumentCard.gestureRecognizers?.removeAll()
            cell.setData(allMumentsData[indexPath.row])
            let tapGestureRecognizer = CardTapGestureRecognizer(target: self, action: #selector(didTapAllMumentView(_:)))
            tapGestureRecognizer.index = indexPath.row
            cell.mumentCard.addGestureRecognizer(tapGestureRecognizer)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 1 :
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyMumentSectionHeader.className) as? MyMumentSectionHeader else { return nil }
            if myMumentData == nil {
                headerCell.removeHistoryButton()
                return headerCell
            }
            headerCell.historyButton.removeTarget(nil, action: nil, for: .allEvents)
            
            headerCell.historyButton.press {
                let mumentHistoryVC = MumentHistoryVC()
                mumentHistoryVC.setHistoryData(userId: self.userId, musicData: self.musicData)
                self.navigationController?.pushViewController(mumentHistoryVC, animated: true)            }
            return headerCell
        case 2:
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllMumentsSectionHeader.className) as? AllMumentsSectionHeader else { return nil }
            headerCell.delegate=self
            return headerCell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if allMumentsData.count == 0 {
            return 0
        }
        switch section {
        case 1:
            return 83.adjustedH
        case 2:
            return 73.adjustedH
        default:
            return 0
        }
    }
    
}

// MARK: - UITableViewDelegate
extension SongDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0:
            cellHeight = 141.adjustedH
        case 1,2:
            cellHeight = UITableView.automaticDimension
        default:
            cellHeight = 0
        }
        return cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30{
            navigationBarView.setTitle(musicData.title)
        } else {
            navigationBarView.setTitle("")
        }
        
        let position = scrollView.contentOffset.y
        if position > (mumentTV.contentSize.height - scrollView.frame.size.height) {
            if fetchMoreFlag {
                fetchMoreData()
            }
        }
    }
    
    private func fetchMoreData() {
        fetchMoreFlag = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(100), execute: {
            self.pageOffset += self.pageLimit
            self.appendMoreAllMuments(isOrderLiked: self.filterFlag, limit: self.pageLimit, offset: self.pageOffset)
            self.mumentTV.reloadData()
        })
    }
}

extension SongDetailVC :AllMumentsSectionHeaderDelegate {
    func sortingFilterButtonClicked(isOrderLiked: Bool) {
        filterFlag = isOrderLiked
        allMumentsData = []
        fetchMoreFlag = true
        pageOffset = 0
        requestGetAllMuments(isOrderLiked: isOrderLiked, limit: 10, offset: 0)
    }
}


// MARK: - Network
extension SongDetailVC {
    private func requestGetSongInfo() {
        SongDetailAPI.shared.getSongInfo(musicId: self.musicData.id ) { [self] networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? SongInfoResponseModel {
                    self.myMumentData = res.myMument
                    
                    let music = res.music
                    self.musicData = MusicDTO(id: music.id, title: music.name, artist: music.artist, albumUrl: music.image)
                    self.mumentTV.reloadSections(IndexSet(0...1), with: .automatic)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestGetAllMuments(isOrderLiked: Bool, limit: Int, offset: Int) {
        SongDetailAPI.shared.getAllMuments(musicId: self.musicData.id , isOrderLiked: isOrderLiked, limit: limit, offset: offset) { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? AllMumentsResponseModel {
                    self.allMumentsData = res.mumentList
                    DispatchQueue.main.async {
                        self.mumentTV.reloadData()
                    }
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func appendMoreAllMuments(isOrderLiked: Bool, limit: Int, offset: Int) {
        SongDetailAPI.shared.getAllMuments(musicId: self.musicData.id , isOrderLiked: isOrderLiked, limit: limit, offset: offset) { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? AllMumentsResponseModel {
                    self.allMumentsData.append(contentsOf: res.mumentList)
                    self.newAllMumentDataCount = res.mumentList.count
                    /// 새로 받아온 데이터의 수가 0인 경우 다시 - offset
                    if self.newAllMumentDataCount == 0 {
                        self.pageOffset -= self.pageLimit
                        self.fetchMoreFlag = false
                    }else {
                        self.fetchMoreFlag = true
                    }
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

class CardTapGestureRecognizer: UITapGestureRecognizer {
    var index: Int = 0
}
