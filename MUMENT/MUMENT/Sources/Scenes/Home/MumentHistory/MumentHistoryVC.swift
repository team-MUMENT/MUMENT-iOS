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
    private let navigationBarView = DefaultNavigationBar()
    private let mumentTV = UITableView( frame: CGRect.zero, style: .grouped)
    
    var musicInfoDataSource: [MumentDetailVCModel] = MumentDetailVCModel.sampleData
    var mumentDataSource: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData
    
    var musicInfoData: HistoryResponseModel.DataMusic = HistoryResponseModel.DataMusic(id: "", name: "", artist: "", image: "")
    var historyData: [HistoryResponseModel.MumentHistory] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setData()
        setTV()
        setClickEventHandlers()
        requestGetHistoryData()
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
    
    func setData(){
        navigationBarView.setTitle("뮤멘트 히스토리")
    }
    
    func setClickEventHandlers(){
        navigationBarView.backbutton.press{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
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
        headerCell.setData(musicInfoData)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        headerCell.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        
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
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
    
}
// MARK: - Network
extension MumentHistoryVC {
    private func requestGetHistoryData() {
        HistoryAPI.shared.getMumentHistoryData(userId: "62cd5d4383956edb45d7d0ef", musicId: "62d2959e177f6e81ee8fa3de", recentOnTop: true) { networkResult in
            switch networkResult {
                
            case .success(let response):
                if let res = response as? HistoryResponseModel {
                    self.musicInfoData = res.music
                    self.historyData = res.mumentHistory
                    self.mumentTV.reloadData()
                }
            default:
                self.makeAlert(title: "네트워킁 오류로 어쩌구..죄송")
            }
        }
    }
    
}
