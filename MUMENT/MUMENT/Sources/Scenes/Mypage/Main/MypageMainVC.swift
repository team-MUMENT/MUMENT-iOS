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
    enum Section: Int, CaseIterable {
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
            case .setting, .service, .info: return 36
            }
        }
        
        var footerHeight: CGFloat {
            switch self {
            case .profile: return 10
            case .setting, .service: return 28
            default: return 0
            }
        }
        
        var headerTitle: String {
            switch self {
            case .setting: return "설정"
            case .service: return "서비스"
            case .info: return "정보"
            default: return ""
            }
        }
        
        var rowTitle: [String] {
            switch self {
            case .setting: return ["알림 설정", "차단 유저 관리"]
            case .service: return ["공지사항", "자주 묻는 질문", "문의하기"]
            case .info: return ["앱 정보", "뮤멘트 소개"]
            default: return []
            }
        }
        
        var rowVC: [UIViewController] {
            switch self {
            case .setting: return [SetNotificationVC(), SetBlockedUserVC()]
            case .service: return [MypageNoticeVC(), UIViewController(), UIViewController()]
            case .info: return [UIViewController(), UIViewController()]
            default: return []
            }
        }
    }
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "마이 페이지")
    }
    private let tableView: UITableView = UITableView().then {
        $0.separatorStyle = .none
        $0.sectionHeaderTopPadding = 0
        $0.backgroundColor = .mBgwhite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.setLayout()
        self.setBackButton()
        self.setTableView()
    }
    
    // MARK: Methods
    private func setBackButton() {
        self.naviView.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.do({
            $0.register(cell: MypageMainTVC.self)
            $0.register(cell: MypageMainProfileTVC.self)
            $0.register(cell: MypageMainFooterTVC.self)
        })
    }
    
    private func requestSignOut() {
        // TODO: ..
    }
    
    private func requestWithDraw() {
        // TODO: ..
    }
}

// MARK: - UITableViewDataSource
extension MypageMainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageMainProfileTVC.className) as? MypageMainProfileTVC else { return UITableViewCell() }
                cell.setNickname(text: "blueingreen")
                return cell
            case .footer:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageMainFooterTVC.className) as? MypageMainFooterTVC else { return UITableViewCell() }
                cell.setVersionLabel(version: "1.0")
                
                cell.setSignOutAction { [weak self] in
                    self?.requestSignOut()
                }
                
                cell.setWithDrawAction { [weak self] in
                    self?.requestWithDraw()
                }
                
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageMainTVC.className) as? MypageMainTVC else { return UITableViewCell() }
                cell.setTitle(text: tableSection.rowTitle[indexPath.row])
                return cell
            }
        } else { return UITableViewCell() }
    }
}

// MARK: - UITableViewDelegate
extension MypageMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tableSection = Section(rawValue: indexPath.section) {
            self.navigationController?.pushViewController(tableSection.rowVC[indexPath.row], animated: true)
        }
    }
    
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
        let headerView: MypageMainHeaderView = MypageMainHeaderView(title: Section(rawValue: section)?.headerTitle ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let tableSection = Section(rawValue: section) {
            return tableSection.footerHeight
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return MypageMainSeparatorView(type: Section(rawValue: section) ?? .profile)
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
