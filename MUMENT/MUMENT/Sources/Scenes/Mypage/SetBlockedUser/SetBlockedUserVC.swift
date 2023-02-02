//
//  SetBlockedUserVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/07.
//

import UIKit
import SnapKit
import Then

final class SetBlockedUserVC: BaseVC {
    
    // MARK: Components
    private lazy var naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "차단 유저 관리")
        $0.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private let tableView: UITableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .mBgwhite
        $0.rowHeight = 80
        $0.allowsSelection = false
    }
    
    private let emptyLabel: UILabel = UILabel().then {
        $0.text = "차단한 유저가 없어요."
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.sizeToFit()
    }
    
    // MARK: Properties
    private var blockedUserList: GetBlockedUserListResponseModel = [] {
        didSet {
            self.emptyLabel.isHidden = !self.blockedUserList.isEmpty
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getBlockedUserList()
    }
    
    // MARK: Methods
    private func setTableView() {
        self.tableView.dataSource = self
        
        self.tableView.register(cell: BlockedUserTVC.self)
    }
}

// MARK: - UITableViewDataSource
extension SetBlockedUserVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blockedUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlockedUserTVC.className) as? BlockedUserTVC else { return UITableViewCell() }
        cell.setData(data: self.blockedUserList[indexPath.row])
        cell.unblockButton.removeTarget(nil, action: nil, for: .allTouchEvents)
        cell.unblockButton.press { [weak self] in
            let mumentAlert = MumentAlertWithButtons(titleType: .containedSubTitleLabel, OKTitle: "차단해제")
            mumentAlert.setTitleSubTitle(
                title: "차단해제하시겠습니까?",
                subTitle: """
해당 사용자의 뮤멘트를
다시 볼 수 있습니다.
"""
            )
            self?.present(mumentAlert, animated: true)
            
            mumentAlert.OKButton.press { [weak self] in
                self?.deleteBlockedUser(userId: self?.blockedUserList[indexPath.row].id ?? 0)
            }
        }
        return cell
    }
}

// MARK: - Network
extension SetBlockedUserVC {
    private func getBlockedUserList() {
        MyPageAPI.shared.getBlockedUserList { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetBlockedUserListResponseModel {
                    self.blockedUserList = result
                    self.tableView.reloadData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func deleteBlockedUser(userId: Int) {
        MyPageAPI.shared.deleteBlockedUser(userId: userId) { networkResult in
            switch networkResult {
            case .success:
                self.getBlockedUserList()
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UI
extension SetBlockedUserVC {
    private func setLayout() {
        self.view.addSubviews([naviView, tableView, emptyLabel])
        
        self.naviView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        self.emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
