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
    private let notificationData: [
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.hideTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.showTabbar()
    }
    
    // MARK: Methods
    private func setNotificationTV() {
        self.notificationTV.delegate = self
        self.notificationTV.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

// MARK: - UITableViewDelegate
extension NotificationVC: UITableViewDelegate {
    
}

// MARK: - UI
extension NotificationVC {
    private func setLayout() {
        view.addSubviews([naviView])
        
        self.naviView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
}
