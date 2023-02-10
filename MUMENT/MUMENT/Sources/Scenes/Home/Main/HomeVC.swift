//
//  HomeVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit

class HomeVC: BaseVC {
    
    // MARK: - Properties
    private let headerView = HomeTVHeader()
    private lazy var homeTV = UITableView()
    private let viewForHeight = MumentForTodayCardView()
    private let headerViewMaxHeight: CGFloat = 107.0
    private let headerViewMinHeight: CGFloat = 50.0
    var carouselData: CarouselResponseModel = CarouselResponseModel(todayDate: "", userId: 0, bannerList: [])
    var mumentForTodayData: MumentForTodayResponseModel?
    var mumentsOfRevisitedData: [MumentsOfRevisitedResponseModel.AgainMument] = []
    var mumentsByTagData: MumentsByTagResponseModel = MumentsByTagResponseModel(title: "", mumentList: [])
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
        self.setLayout()
        self.setButtonActions()
        self.checkUserPenalty(self)
    }
    
    override func viewWillAppear(_ animate: Bool) {
        super.viewWillAppear(animate)
        
        self.requestGetCarouselData()
        self.showTabbar()
        self.getIsNewNotification()
    }
    
    /// timer를 View가 뜨기전에 시작해버리면 첫번째 배너가 이미 넘어가 버림
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: .sendViewState, object: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: .sendViewState, object: false)
    }
    
    // MARK: - Functions
    private func setTV() {
        homeTV.delegate = self
        homeTV.dataSource = self
        
        homeTV.register(cell: CarouselTVC.self, forCellReuseIdentifier: CarouselTVC.className)
        homeTV.register(cell: MumentsOfRevisitedTVC.self, forCellReuseIdentifier: MumentsOfRevisitedTVC.className)
        homeTV.register(cell: MumentForTodayTVC.self, forCellReuseIdentifier: MumentForTodayTVC.className)
        homeTV.register(cell: MumentsByTagTVC.self, forCellReuseIdentifier: MumentsByTagTVC.className)
        
        homeTV.estimatedRowHeight = 44
        homeTV.rowHeight = 48
        homeTV.separatorStyle = .none
        homeTV.showsVerticalScrollIndicator = false
        
        homeTV.contentInset = UIEdgeInsets(top: headerViewMaxHeight, left: 0, bottom: 0, right: 0)
    }
    
    private func setButtonActions(){
        headerView.setButtonAction(vc: self, function: self.requestGetCarouselData)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        if let todayMument = self.mumentForTodayData?.todayMument {
            mumentDetailVC.setData(
                mumentId: todayMument.mumentID,
                musicData: MusicDTO(
                    id: todayMument.music.id,
                    title: todayMument.music.name,
                    artist: todayMument.music.artist,
                    albumUrl: todayMument.music.image
                )
            )
        }
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
    
}

// MARK: - UI
extension HomeVC {
    
    private func setLayout() {
        view.addSubviews([homeTV,headerView])
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(headerViewMaxHeight)
        }
        
        homeTV.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUI() {
        self.view.backgroundColor = .mBgwhite
        self.homeTV.backgroundColor = .mBgwhite
    }
}

// MARK: - CarouselCVCDelegate
extension HomeVC: CarouselCVCDelegate {
    func carouselCVCSelected(data: CarouselResponseModel.BannerList) {
        let songDetailVC = SongDetailVC()

        songDetailVC.setDetailData(userId: carouselData.userId,
            musicData:
                MusicDTO(id: data.music.id,
                         title: data.music.name,
                         artist: data.music.artist,
                         albumUrl: data.music.image)
        )
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

// MARK: - MumentsOfRevisitedCVCDelegate
extension HomeVC: MumentsOfRevisitedCVCDelegate {
    func mumentsOfRevisitedCVCSelected(data: MumentsOfRevisitedResponseModel.AgainMument) {
        let mumentDetailVC = MumentDetailVC()
        let music = data.music
        mumentDetailVC.setData(mumentId: data.mumentId, musicData: MusicDTO(id: music.id, title: music.name, artist: music.artist, albumUrl: music.image))
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
}

// MARK: - MumentsByTagCVCDelegate
extension HomeVC: MumentsByTagCVCDelegate {
    func mumentsByTagCVCSelected(data: MumentsByTagResponseModel.MumentList) {
        let mumentDetailVC = MumentDetailVC()
        let music = data.music
        mumentDetailVC.setData(mumentId: data.id, musicData: MusicDTO(id: music.id, title: music.name, artist: music.artist, albumUrl: music.image))
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTVC.className, for: indexPath) as? CarouselTVC else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setData(carouselData)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentForTodayTVC.className, for: indexPath) as? MumentForTodayTVC else {
                return UITableViewCell()
            }
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
            cell.mumentCardView.addGestureRecognizer(tapGestureRecognizer)
            if let todayMument = mumentForTodayData {
                cell.setData(todayMument)
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentsOfRevisitedTVC.className, for: indexPath) as? MumentsOfRevisitedTVC else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setData(mumentsOfRevisitedData)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentsByTagTVC.className, for: indexPath) as? MumentsByTagTVC else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setData(mumentsByTagData)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0:
            cellHeight = 280
        case 1:
            guard let content = mumentForTodayData?.todayMument.content else { return 300 }
            let height = viewForHeight.getContentSize(content: content).height
            print("높이", height)
            cellHeight = 275 + height
        case 2:
            cellHeight = 350
        case 3:
            cellHeight = 300
        default:
            cellHeight = 0
        }
        return cellHeight
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            headerView.snp.updateConstraints{
                $0.height.equalTo(max(abs(scrollView.contentOffset.y), headerViewMinHeight))
            }
        } else {
            headerView.snp.updateConstraints{
                $0.height.equalTo(headerViewMinHeight)
            }
        }
        let offset = -scrollView.contentOffset.y
        let percentage = (offset-50)/50
        
        headerView.setButtonAlpha(percentage: percentage)
    }
}

// MARK: - Network
extension HomeVC {
    private func requestGetCarouselData() {
        HomeAPI.shared.getCarouselData() { networkResult in
            switch networkResult {
                
            case .success(let response):
                if let res = response as? CarouselResponseModel {
                    self.carouselData = res
                    self.requestGetMumentForTodayData()
                    self.setTV()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestGetMumentForTodayData() {
        HomeAPI.shared.getMumentForTodayData() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? MumentForTodayResponseModel {
                    self.mumentForTodayData = res
                    self.requestGetMumentsOfRevisitedData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestGetMumentsOfRevisitedData() {
        HomeAPI.shared.getMumentOfRevisitedData() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? MumentsOfRevisitedResponseModel {
                    self.mumentsOfRevisitedData = res.againMument
                    self.requestGetMumentsByTagData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestGetMumentsByTagData() {
        HomeAPI.shared.getMumentsByTagData() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? MumentsByTagResponseModel {
                    self.mumentsByTagData = res
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                        self.homeTV.reloadData()
                    }
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func getIsNewNotification() {
        NotificationAPI.shared.getIsNewNotification { networkResult in
            switch networkResult {
            case .success(let response):
                if let result: GetIsNewNotificationResponseModel = response as? GetIsNewNotificationResponseModel {
                    self.headerView.setNotificationButtonIcon(isNew: result.exist)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
