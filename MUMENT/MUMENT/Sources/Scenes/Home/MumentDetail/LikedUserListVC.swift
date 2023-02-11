//
//  LikedUserListVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/05.
//

import UIKit
import SnapKit
import Then

final class LikedUserListVC: BaseVC {
  
    // MARK: - Components
    private lazy var navigationBarView = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "좋아요한 사용자")
        $0.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private let likedUserTV = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .mBgwhite
        $0.allowsSelection = false
    }
    
    // MARK: - Properties
    private var mumentId: Int = 0
    
    private var likedUserListData: [LikedUserListResponseModel] = []
    private var newLikedUserDataCount = 0
    private var fetchMoreFlag: Bool = true
    
    private var pageLimit: Int = 10
    private var pageOffset: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetProperty()
        requestGetLikedUserList(mumentId: self.mumentId, limit: 10, offset: 0)
    }
    
    // MARK: - Function
    private func setTV() {
        self.likedUserTV.dataSource = self
        self.likedUserTV.register(cell: LikedUserListTVC.self)
    }
    
    func setMumentId(mumentId: Int) {
        self.mumentId = mumentId
    }
    
    private func resetProperty() {
        fetchMoreFlag = true
        pageOffset = 0
    }
    
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension LikedUserListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedUserListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikedUserListTVC.className) as? LikedUserListTVC else { return UITableViewCell() }
        cell.setLikedUserData(userData: self.likedUserListData[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (likedUserTV.contentSize.height - scrollView.frame.size.height) {
            if fetchMoreFlag {
                fetchMoreData()
            }
        }
    }
    
    private func fetchMoreData() {
        fetchMoreFlag = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(100), execute: {
            self.pageOffset += self.pageLimit
            self.requestMoreLikedUserData(mumentId: self.mumentId, limit: self.pageLimit, offset: self.pageOffset)
            self.likedUserTV.reloadData()
        })
    }
}


// MARK: - UI
extension LikedUserListVC {
    private func setLayout() {
        self.view.addSubviews([navigationBarView, likedUserTV])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        likedUserTV.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(17)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
}

// MARK: - Network
extension LikedUserListVC {
    private func requestGetLikedUserList(mumentId: Int, limit: Int, offset: Int) {
        self.startActivityIndicator()
        LikeAPI.shared.getLikedUsetList(mumentId: mumentId, limit: limit, offset: offset) {
            networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? [LikedUserListResponseModel] {
                    self.likedUserListData = result
                    DispatchQueue.main.async {
                        self.likedUserTV.reloadData()
                        self.stopActivityIndicator()
                    }
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestMoreLikedUserData(mumentId: Int, limit: Int, offset: Int) {
        self.startActivityIndicator()
        LikeAPI.shared.getLikedUsetList(mumentId: mumentId, limit: limit, offset: offset) {
            networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? [LikedUserListResponseModel] {
                    self.likedUserListData.append(contentsOf: result)
                    self.newLikedUserDataCount = result.count
                    /// 새로 받아온 데이터의 수가 0인 경우 다시 - offset
                    if self.newLikedUserDataCount == 0 {
                        self.pageOffset -= self.pageLimit
                    }
                    self.fetchMoreFlag = !(self.newLikedUserDataCount == 0)
                    self.stopActivityIndicator()
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

