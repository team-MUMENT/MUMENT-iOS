//
//  MypageMainVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import Then
import SnapKit

final class MypageMainVC: BaseVC {
    
    enum Number {
        static let sections: Int = 5
        static let separatorHorizontalInset: CGFloat = 20
    }
    
    enum Section: Int {
        case profile = 0
        case setting = 1
        case service = 2
        case info = 3
        case footer = 4
        
        var rows: Int {
            switch self {
            case .profile: return 1
            case .setting: return 2
            case .service: return 3
            case .info: return 2
            case .footer: return 1
            }
        }
        
        var rowHeight: CGFloat {
            switch self {
            case .profile: return 120
            case .setting, .service, .info: return 44
            case .footer: return 95
            }
        }
        
        var headerHeight: CGFloat {
            switch self {
            case .profile, .footer: return 0
            case .setting, .service, .info: return 56
            }
        }
    }
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "마이 페이지")
    }
    private let tableView: UITableView = UITableView().then {
        $0.separatorInset.left = Number.separatorHorizontalInset
        $0.separatorInset.right = Number.separatorHorizontalInset
        $0.separatorColor = .mGray1
        $0.backgroundColor = .mPurple2
        $0.sectionHeaderTopPadding = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButton()
        self.setTableView()
    }
    
    // MARK: Methods
    private func setBackButton() {
        self.naviView.backButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension MypageMainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Number.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = Section(rawValue: section) {
            return tableSection.rows
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableSection = Section(rawValue: indexPath.section) {
            switch tableSection {
            case .profile:
                return UITableViewCell()
            case .setting:
                return UITableViewCell()
            case .service:
                return UITableViewCell()
            case .info:
                return UITableViewCell()
            case .footer:
                return UITableViewCell()
            }
        } else { return UITableViewCell() }
    }
}

// MARK: - UITableViewDelegate
extension MypageMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tableSection = Section(rawValue: indexPath.section) {
            return tableSection.rowHeight
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tableSection = Section(rawValue: section) {
            return tableSection.headerHeight
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel().then {
            $0.text = "header"
            $0.backgroundColor = .orange
        }
        return label
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UI
extension MypageMainVC {
    private func setLayout() {
        self.view.addSubviews([naviView, tableView])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
