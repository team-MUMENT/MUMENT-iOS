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
    
    var songInfoDataSource: [SongDetailInfoModel] = SongDetailInfoModel.sampleData
    var myMumentDataSource: [MumentCardBySongModel] = MumentCardBySongModel.myMumentSampleData
    var allMumentsDataSource: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData
    var songInfoData: SongInfoResponseModel.Music = SongInfoResponseModel.Music(id: "", name: "", image: "", artist: "")
    var myMumentData: SongInfoResponseModel.MyMument = SongInfoResponseModel.MyMument(feelingTag: [], updatedAt: "", music: SongInfoResponseModel.MyMument.MyMumentMusic(id: ""), id: "", likeCount: 0, impressionTag: [], isDeleted: true, isPrivate: true, cardTag: [], date: "", isFirst: true, isLiked: true, v: 0, user: SongInfoResponseModel.MyMument.User(id: "", name: "", image: ""), createdAt: "", content: "")
    var allMumentsData: [AllMumentsResponseModel.MumentList] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
        setButtonActions()
        requestGetSongInfo()
        requestGetAllMuments()
        
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
        mumentTV.separatorStyle = .none
        mumentTV.showsVerticalScrollIndicator = false
    }
    
    private func setButtonActions(){
        navigationBarView.backbutton.press{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        print("mumentDetailVC")
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
        switch section {
        case 0 :
            return 1
        case 1 :
            return myMumentDataSource.count
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
            cell.setData(songInfoDataSource[0])
            cell.setData(songInfoData)
            cell.writeMumentButton.press{
                self.tabBarController?.selectedIndex = 1
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.setData(myMumentData)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
            cell.mumentCard.addGestureRecognizer(tapGestureRecognizer)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.setData(allMumentsData[indexPath.row])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
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
            headerCell.historyButton.press{
                let mumentHistoryVC = MumentHistoryVC()
                self.navigationController?.pushViewController(mumentHistoryVC, animated: true)
            }
            return headerCell
        case 2:
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllMumentsSectionHeader.className) as? AllMumentsSectionHeader else { return nil }
            return headerCell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1,2 :
            return 50
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
            navigationBarView.setTitle(songInfoDataSource[0].songtitle)
        } else {
            navigationBarView.setTitle("")
        }
    }
}

// MARK: - Network
extension SongDetailVC {
    private func requestGetSongInfo() {
        SongDetailAPI.shared.getSongInfo(musicId: "62d2959e177f6e81ee8fa3de", userId: "62cd5d4383956edb45d7d0ef") { networkResult in
        switch networkResult {
           
        case .success(let response):
            print(response,"ppppppp")
          if let res = response as? SongInfoResponseModel {
              print(res,"jjjjjj")
              self.songInfoData = res.music
              self.myMumentData = res.myMument
              self.mumentTV.reloadData()
          }
        default:
          self.makeAlert(title: "네트워킁 오류로 어쩌구..죄송")
        }
      }
    }
    
  private func requestGetAllMuments() {
      SongDetailAPI.shared.getAllMuments(musicId: "62d2959e177f6e81ee8fa3de", userId: "62cd5d4383956edb45d7d0ef", isOrderLiked: true) { networkResult in
      switch networkResult {
         
      case .success(let response):
        if let res = response as? AllMumentsResponseModel {
            self.allMumentsData = res.mumentList
            self.mumentTV.reloadData()
        }

      default:
        self.makeAlert(title: "네트워킁 오류로 어쩌구..죄송")
      }
    }
  }
}
