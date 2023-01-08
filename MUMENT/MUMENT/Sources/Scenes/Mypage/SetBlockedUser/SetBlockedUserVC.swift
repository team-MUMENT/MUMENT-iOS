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
    
    // MARK: Properties
    private var blockedUserList: GetBlockedUserListResponseModel = [
        GetBlockedUserListResponseModelElement(id: "1", image: "https://aws.com/85759_2018_031_0001.jpg", name: "나는 못된 사용자야 1"),
        GetBlockedUserListResponseModelElement(id: "2", image: "https://aws.com/85759_2018_031_0001.jpg", name: "나는 못된 사용자야 2"),
        GetBlockedUserListResponseModelElement(id: "3", image: "hws.com/85759_2018_031_0001.jpg", name: "나는 못된 사용자야 3"),
        GetBlockedUserListResponseModelElement(id: "4", image: "https://aws.com/85759_2018_031_0001.jpg", name: "나는 못된 사용자야 4"),
        GetBlockedUserListResponseModelElement(id: "5", image: "https://aws.com/85759_2018_031_0001.jpg", name: "나는 못된 사용자야 5")
    ]
    
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
            self?.deleteBlockedUser()
        }
        return cell
    }
}

// MARK: - Network
extension SetBlockedUserVC {
    private func getBlockedUserList() {
        debugPrint("getBlockedUserList")
    }
    
    private func deleteBlockedUser() {
        debugPrint("deleteBlockedUser")
    }
}

// MARK: - UI
extension SetBlockedUserVC {
    private func setLayout() {
        self.view.addSubviews([naviView, tableView])
        
        self.naviView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
