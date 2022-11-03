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

class SongDetailVC: BaseVC {
    
    // MARK: - Properties
    private let navigationBarView = DefaultNavigationBar()
    private let mumentTV = UITableView( frame: CGRect.zero, style: .grouped)
    
    var myMumentDataSource: [MumentCardBySongModel] = MumentCardBySongModel.myMumentSampleData
    var allMumentsDataSource: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData
    var songInfoData: SongInfoResponseModel.Music = SongInfoResponseModel.Music(id: "", name: "", image: "", artist: "")
    var myMumentData: SongInfoResponseModel.MyMument? = SongInfoResponseModel.MyMument(feelingTag: [], updatedAt: "", music: SongInfoResponseModel.MyMument.MyMumentMusic(id: ""), id: "", likeCount: 0, impressionTag: [], isDeleted: true, isPrivate: true, cardTag: [], date: "", isFirst: true, isLiked: true, v: 0, user: SongInfoResponseModel.MyMument.User(id: "", name: "", image: ""), createdAt: "", content: "")
    var allMumentsData: [AllMumentsResponseModel.MumentList] = []
    var musicId: String?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
        setButtonActions()
        requestGetSongInfo()
        requestGetAllMuments(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetSongInfo()
        requestGetAllMuments(true)
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
        mumentTV.separatorStyle = .none
        mumentTV.showsVerticalScrollIndicator = false
    }
    
    private func setButtonActions(){
        navigationBarView.backButton.press{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.mumentId = self.myMumentData?.id
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        print("mumentDetailVC")
    }
    
    @objc func didTapAllMumentView(_ sender: UITapGestureRecognizer, index: Int) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.mumentId = self.allMumentsData[index].id
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
}

// MARK: - UI
extension SongDetailVC {
    
    private func setLayout() {
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if myMumentData == nil && allMumentsData.count == 0 {
            if section == 0 {
                return 1
            } else { return 0 }
        } else {
            switch section {
            case 0 :
                return 1
            case 1 :
                return 1
//                if myMumentData == nil {
//                    return 1
//                } else {
//                    return 1
//                }
            case 2:
                return allMumentsData.count
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongInfoTVC.className, for: indexPath) as? SongInfoTVC else {
                return UITableViewCell()
            }
            cell.setData(songInfoData)
            cell.writeMumentButton.press{
                self.tabBarController?.selectedIndex = 1
            }
            return cell
        case 1:
            if myMumentData == nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SongDetailMyMumentEmptyTVC.className, for: indexPath) as? SongDetailMyMumentEmptyTVC else { return UITableViewCell() }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                    return UITableViewCell()
                }
                cell.setData(myMumentData ?? SongInfoResponseModel.MyMument(feelingTag: [], updatedAt: "", music: SongInfoResponseModel.MyMument.MyMumentMusic(id: ""), id: "", likeCount: 0, impressionTag: [], isDeleted: true, isPrivate: true, cardTag: [], date: "", isFirst: true, isLiked: true, v: 0, user: SongInfoResponseModel.MyMument.User(id: "", name: "", image: ""), createdAt: "", content: ""))
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
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAllMumentView(.init(), index: indexPath.row)))
//            cell.mumentCard.addGestureRecognizer(tapGestureRecognizer)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let mumentDetailVC = MumentDetailVC()
            print("이게머져",self.allMumentsData[indexPath.row])
            mumentDetailVC.mumentId = self.allMumentsData[indexPath.row].id
            self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 1 :
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyMumentSectionHeader.className) as? MyMumentSectionHeader else { return nil }
            headerCell.historyButton.removeTarget(nil, action: nil, for: .allEvents)
            headerCell.historyButton.press {
                let mumentHistoryVC = MumentHistoryVC()
                mumentHistoryVC.musicId = self.musicId
                self.navigationController?.pushViewController(mumentHistoryVC, animated: true)
            }
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
        switch section {
        case 1 :
            return 50
        case 2:
            return 40
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
            cellHeight = 200
        case 1,2:
            cellHeight = UITableView.automaticDimension
        default:
            cellHeight = 0
        }
        return cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0{
            navigationBarView.setTitle(songInfoData.name)
        } else {
            navigationBarView.setTitle("")
        }
    }
}

extension SongDetailVC :AllMumentsSectionHeaderDelegate {
    func sortingFilterButtonClicked(_ recentOnTop: Bool) {
        requestGetAllMuments(recentOnTop)
    }
}


// MARK: - Network
extension SongDetailVC {
    private func requestGetSongInfo() {
        SongDetailAPI.shared.getSongInfo(musicId: self.musicId ?? "", userId: UserInfo.shared.userId ?? "") { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? SongInfoResponseModel {
                    self.songInfoData = res.music
                    self.myMumentData = res.myMument
                    self.mumentTV.reloadSections(IndexSet(0...1), with: .automatic)
                }
            default:
                self.makeAlert(title: """
 네트워크 오류로 인해 연결에 실패했어요! 🥲
 잠시 후에 다시 시도해 주세요.
 """)
            }
        }
    }
    
    private func requestGetAllMuments(_ isOrderLiked: Bool) {
        SongDetailAPI.shared.getAllMuments(musicId: self.musicId ?? "", userId: UserInfo.shared.userId ?? "", isOrderLiked: isOrderLiked) { networkResult in
            switch networkResult {
                
            case .success(let response):
                if let res = response as? AllMumentsResponseModel {
                    self.allMumentsData = res.mumentList
                    self.mumentTV.reloadData()
                }
                
            default:
                self.makeAlert(title: """
 네트워크 오류로 인해 연결에 실패했어요! 🥲
 잠시 후에 다시 시도해 주세요.
 """)
            }
        }
    }
}
