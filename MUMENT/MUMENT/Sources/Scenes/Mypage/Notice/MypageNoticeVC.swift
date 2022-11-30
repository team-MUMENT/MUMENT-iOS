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
    private var noticeList: GetNoticeListResponseModel = [
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
        GetNoticeListResponseModelElement(id: "123", title: "게시물 이름 1", createdAt: "2022. 10. 18"),
    ]
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
