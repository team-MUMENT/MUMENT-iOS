//
//  NotificationVC.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/21.
//

import UIKit
import SnapKit
import Then

final class NotificationVC: BaseVC {
    
    // MARK: Components
    private let naviView = DefaultNavigationBar(naviType: .leftArrowRightSetting).then {
        $0.setTitleLabel(title: "소식")
    }
    
    private let notificationTV = UITableView().then {
        $0.estimatedRowHeight = 105
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.register(NotificationTVC.self, forCellReuseIdentifier: NotificationTVC.className)
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: Properties
    private var notificationList: GetNotificationListResponseModel = []
    private var unreadNotifiationIdList: [Int] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.hideTabbar()
        self.setNotificationTV()
        self.setBackButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getNotificationList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.showTabbar()
    }
    
    // MARK: Methods
    private func setNotificationTV() {
        self.notificationTV.delegate = self
        self.notificationTV.dataSource = self
        self.notificationTV.register(cell: NotificationTVC.self)
    }
    
    private func setUnreadNotificationList() {
        self.unreadNotifiationIdList = []
        self.notificationList.forEach { noti in
            if !noti.isRead {
                self.unreadNotifiationIdList.append(noti.id)
            }
        }
    }
    
    private func setBackButtonAction() {
        self.naviView.setBackButtonAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTVC.className) as? NotificationTVC else { return UITableViewCell() }
        cell.setData(data: self.notificationList[indexPath.row])
        
        cell.deleteButton.press { [weak self] in
            self?.deleteNotification(id: self?.notificationList[indexPath.row].id ?? 0)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotificationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UI
extension NotificationVC {
    private func setLayout() {
        view.addSubviews([naviView, notificationTV])
        
        self.naviView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        self.notificationTV.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom).offset(13)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Network
extension NotificationVC {
    private func getNotificationList() {
        NotificationAPI.shared.getNotificationList { networkResult in
            switch networkResult {
            case .success(let t):
                if let result = t as? GetNotificationListResponseModel {
                    self.notificationList = result
                    self.setUnreadNotificationList()
                    self.readNotification(idList: self.unreadNotifiationIdList)
                    self.notificationTV.reloadData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func deleteNotification(id: Int) {
        NotificationAPI.shared.deleteNotifiction(id: id) { networkResult in
            switch networkResult {
            case .success:
                self.getNotificationList()
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func readNotification(idList: [Int]) {
        NotificationAPI.shared.readNotification(idList: idList) { networkResult in
            switch networkResult {
            case .success: break
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
