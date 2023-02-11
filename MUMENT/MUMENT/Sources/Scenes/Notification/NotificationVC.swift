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
    
    enum NotificationType: String {
        case like = "like"
        case notice = "notice"
    }
    
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
    
    private let emptyLabel: UILabel = UILabel().then {
        $0.text = "받은 소식이 없습니다."
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.sizeToFit()
    }
    
    // MARK: Properties
    private var notificationList: GetNotificationListResponseModel = [] {
        didSet {
            self.emptyLabel.isHidden = !self.notificationList.isEmpty
        }
    }
    
    private var unreadNotifiationIdList: [Int] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.hideTabbar()
        self.setNotificationTV()
        self.setNaviViewAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getNotificationList()
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
    
    private func setNaviViewAction() {
        self.naviView.setBackButtonAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        self.naviView.setSettingButtonAction { [weak self] in
            let setNotificationVC = SetNotificationVC()
            self?.navigationController?.pushViewController(setNotificationVC, animated: true)
        }
    }
    
    private func pushMumentDetailVC(mumentId: Int, musicData: MusicDTO) {
        let mumentDetailVC = MumentDetailVC()
        mumentDetailVC.setData(mumentId: mumentId, musicData: musicData)
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
    }
    
    private func pushNoticeDetailVC(noticeId: Int) {
        let detailVC = MypageNoticeDetailVC(noticeId: noticeId)
        self.navigationController?.pushViewController(detailVC, animated: true)
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
        
        cell.deleteButton.removeTarget(nil, action: nil, for: .allTouchEvents)
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
        
        let data: GetNotificationListResponseModelElement = self.notificationList[indexPath.row]
        if let type: NotificationType = NotificationType(rawValue: data.type) {
            switch type {
            case .like:
                let musicData: MusicDTO = MusicDTO(
                    id: data.like.music.id ?? "",
                    title: data.like.music.name ?? "",
                    artist: data.like.music.artist ?? "",
                    albumUrl: data.like.music.image ?? ""
                )
                self.pushMumentDetailVC(mumentId: data.linkID, musicData: musicData)
            case .notice:
                self.pushNoticeDetailVC(noticeId: data.linkID)
            }
        }
    }
}

// MARK: - UI
extension NotificationVC {
    private func setLayout() {
        view.addSubviews([naviView, notificationTV, emptyLabel])
        
        self.naviView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        self.notificationTV.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom).offset(13)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Network
extension NotificationVC {
    private func getNotificationList() {
        self.startActivityIndicator()
        NotificationAPI.shared.getNotificationList { networkResult in
            switch networkResult {
            case .success(let t):
                if let result = t as? GetNotificationListResponseModel {
                    self.notificationList = result
                    self.setUnreadNotificationList()
                    self.readNotification(idList: self.unreadNotifiationIdList)
                    self.notificationTV.reloadData()
                    self.stopActivityIndicator()
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func deleteNotification(id: Int) {
        self.startActivityIndicator()
        NotificationAPI.shared.deleteNotifiction(id: id) { networkResult in
            switch networkResult {
            case .success:
                self.getNotificationList()
                self.stopActivityIndicator()
            default:
                self.stopActivityIndicator()
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
