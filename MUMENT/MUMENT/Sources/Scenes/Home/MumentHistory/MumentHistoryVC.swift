//
//  MumentHistoryVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/16.
//

import UIKit
import SnapKit
import Then

class MumentHistoryVC: BaseVC {
    
    // MARK: - Properties
    private let navigationBarView = DefaultNavigationBar().then {
        $0.setTitle("뮤멘트 히스토리")
    }
    private let mumentTV = UITableView( frame: CGRect.zero, style: .grouped)
    
    var musicInfoDummyData: [MumentDetailResponseModel] = MumentDetailResponseModel.sampleData
    var mumentDummyData: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData
    
    var musicData: MusicDTO = MusicDTO(id: "", title: "", artist: "", albumUrl: "")
    var historyData: [HistoryResponseModel.MumentHistory] = []
    var musicId: String = ""
    var userId: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
        setClickEventHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetHistoryData(recentOnTop: true, limit: 10, offset: 0)
    }
    
    // MARK: - Functions
    private func setTV() {
        mumentTV.delegate = self
        mumentTV.dataSource = self
        mumentTV.backgroundColor = .mBgwhite
        mumentTV.register(cell: MumentCardBySongTVC.self, forCellReuseIdentifier: MumentCardBySongTVC.className)
        mumentTV.register(MumentHistoryTVHeader.self, forHeaderFooterViewReuseIdentifier: MumentHistoryTVHeader.className)
        
        mumentTV.separatorStyle = .none
        mumentTV.showsVerticalScrollIndicator = false
    }
    
    func setHistoryData(userId: Int, musicData: MusicDTO) {
        self.userId = userId
        self.musicData = musicData
        self.musicId = musicData.id
    }
    
    func setClickEventHandlers(){
        navigationBarView.backButton.press{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
        print("디테일", self.userId)
        songDetailVC.setDetailData(userId: self.userId, musicId: self.musicId)
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

// MARK: - UI
extension MumentHistoryVC {
    
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
extension MumentHistoryVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return historyData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.setData(historyData[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MumentHistoryTVHeader.className) as? MumentHistoryTVHeader else { return nil }
        headerCell.setData(musicData)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        headerCell.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        headerCell.delegate=self
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
}

// MARK: - UITableViewDelegate
extension MumentHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0:
            cellHeight = UITableView.automaticDimension
        default:
            cellHeight = 0
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.mumentId = historyData[indexPath.row].id
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
    
}

extension MumentHistoryVC :MumentHistoryTVHeaderDelegate {
    func sortingFilterButtonClicked(_ recentOnTop: Bool) {
        requestGetHistoryData(recentOnTop: recentOnTop, limit: 10, offset: 0)
    }
}

// MARK: - Network
extension MumentHistoryVC {
    private func requestGetHistoryData(recentOnTop: Bool, limit: Int, offset: Int) {
        
        HistoryAPI.shared.getMumentHistoryData(userId: self.userId, musicId: self.musicId, recentOnTop: recentOnTop, limit: limit, offset: offset) { networkResult in
            switch networkResult {
                
            case .success(let response):
                if let res = response as? HistoryResponseModel {
                    self.historyData = res.mumentHistory
                    self.mumentTV.reloadData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
}
