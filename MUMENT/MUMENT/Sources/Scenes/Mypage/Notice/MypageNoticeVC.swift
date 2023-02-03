//
//  MypageNoticeVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/30.
//

import UIKit
import Then
import SnapKit

final class MypageNoticeVC: BaseVC {
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "공지사항")
    }
    
    private let tableView: UITableView = UITableView().then {
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.backgroundColor = .mBgwhite
        $0.rowHeight = 82
    }
    
    // MARK: Properties
    private var noticeList: GetNoticeListResponseModel = []
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButton()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getNoticeList()
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
        
        self.tableView.register(cell: MypageNoticeTVC.self)
    }
}

// MARK: - UITableViewDataSource
extension MypageNoticeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageNoticeTVC.className) as? MypageNoticeTVC else { return UITableViewCell() }
        cell.setData(data: self.noticeList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MypageNoticeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = MypageNoticeDetailVC(noticeId: self.noticeList[indexPath.row].id)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Network
extension MypageNoticeVC {
    private func getNoticeList() {
        MyPageAPI.shared.getNoticeList { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetNoticeListResponseModel {
                    self.noticeList = result
                    self.tableView.reloadData()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UI
extension MypageNoticeVC {
    private func setLayout() {
        self.view.addSubviews([naviView, tableView])
        
        self.naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.naviView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
