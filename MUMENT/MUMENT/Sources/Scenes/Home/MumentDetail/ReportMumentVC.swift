//
//  ReportMumentVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

final class ReportMumentVC: BaseVC {
    
    // MARK: - Components
    private lazy var navigationBarView = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "신고하기")
        $0.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private let reportMumentTV = UITableView( frame: CGRect.zero, style: .grouped).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = .none
        $0.backgroundColor = .mBgwhite
        $0.allowsMultipleSelection = true
    }
    
    private let reportDoneButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("신고하기", for: .normal)
    }
    
    // MARK: - Properties
    private var reportCategoryList: [String] = ["관련 없는 내용이에요.", "개인정보가 노출될 위험이 있어요.", "욕설, 혐오, 차별 등 부적절한 내용이 있어요.", "음란적, 선정적인 유해한 콘텐츠를 포함하고 있어요.", "같은 내용을 도배하고 있어요.", "부적절한 홍보 또는 광고가 포함되어 있어요.", "기타"]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
    }
    
    // MARK: - Function
    private func setTV() {
        self.reportMumentTV.dataSource = self
        self.reportMumentTV.delegate = self
        self.reportMumentTV.register(cell: ReportMumentTVC.self)
        self.reportMumentTV.register(ReportMumentHeader.self, forHeaderFooterViewReuseIdentifier: ReportMumentHeader.className)
        self.reportMumentTV.register(ReportMumentFooter.self, forHeaderFooterViewReuseIdentifier: ReportMumentFooter.className)
        reportMumentTV.contentInsetAdjustmentBehavior = .automatic
        if #available(iOS 15, *) {
            reportMumentTV.sectionHeaderTopPadding = 0
        }
    }
}

extension ReportMumentVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return reportCategoryList.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReportMumentTVC.className) as? ReportMumentTVC else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.setCategoryTitle(title: reportCategoryList[indexPath.row])
        case 1:
            cell.setBlockCell()
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReportMumentHeader.className) as? ReportMumentHeader else { return nil }
            return headerCell
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            guard let footerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReportMumentFooter.className) as? ReportMumentFooter else { return nil }
            footerCell.setTextViewDelegate(vc: self)
            return footerCell
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 95
        default:
            return .leastNormalMagnitude
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 148
        case 1:
            return 58
        default: return 0
        }
    }
    
}

// MARK: - NameUITextViewDelegate
extension ReportMumentVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("됨")
    }
}

// MARK: - UI
extension ReportMumentVC {
    private func setLayout() {
        self.view.addSubviews([navigationBarView, reportMumentTV, reportDoneButton])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        reportMumentTV.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(reportDoneButton.snp.top)
        }
        
        reportDoneButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().offset(-39)
            $0.height.equalTo(47)
        }
    }
}
