//
//  ReportMumentVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

protocol reportMumentDelegate: AnyObject {
    func sendIsEtcSelected(isSelected: Bool)
}

final class ReportMumentVC: BaseVC {
    
    // MARK: - Components
    private lazy var navigationBarView = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "신고하기")
        $0.backgroundColor = .mBgwhite
        $0.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private let reportMumentTV = UITableView( frame: CGRect.zero, style: .grouped).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 86, right: 0)
        $0.separatorStyle = .none
        $0.backgroundColor = .mBgwhite
        $0.showsVerticalScrollIndicator = false
        $0.allowsMultipleSelection = true
    }
    
    // MARK: - Properties
    weak var delegate: reportMumentDelegate?
    
    private var mumentId = 0
    
    private var reportCategoryList: [String] = ["관련 없는 내용이에요.", "개인정보가 노출될 위험이 있어요.", "욕설, 혐오, 차별 등 부적절한 내용이 있어요.", "음란적, 선정적인 유해한 콘텐츠를 포함하고 있어요.", "같은 내용을 도배하고 있어요.", "부적절한 홍보 또는 광고가 포함되어 있어요.", "기타"]
    
    private var selectedCategoryList: [Int] = [] {
        didSet {
            self.setDoneButtonStatus()
        }
    }
    
    private var isBlockChecked: Bool = false
    
    private var blockReason: String = ""
    
    private var isEtcChecked = false
    
    private var heightOfKeyBoard: CGFloat = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardObserver()
        isBlockChecked = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    // MARK: - Function
    func setMumentId(mumentId: Int) {
        self.mumentId = mumentId
    }
    
    private func setTV() {
        self.reportMumentTV.dataSource = self
        self.reportMumentTV.delegate = self
        self.reportMumentTV.register(cell: ReportMumentTVC.self)
        self.reportMumentTV.register(ReportMumentHeader.self, forHeaderFooterViewReuseIdentifier: ReportMumentHeader.className)
        self.reportMumentTV.register(ReportMumentFooter.self, forHeaderFooterViewReuseIdentifier: ReportMumentFooter.className)
        self.reportMumentTV.register(ReportDoneButtonFooterView.self, forHeaderFooterViewReuseIdentifier: ReportDoneButtonFooterView.className)
        
        reportMumentTV.contentInsetAdjustmentBehavior = .automatic
        if #available(iOS 15, *) {
            reportMumentTV.sectionHeaderTopPadding = 0
        }
        /// 키보드 처리 
        self.hideKeyboardWhenTappedAround()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let footerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReportMumentFooter.className) as? ReportMumentFooter else { return nil }
            footerCell.delegate = self
            self.delegate = footerCell
            return footerCell
        case 1:
            guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReportDoneButtonFooterView.className) as? ReportDoneButtonFooterView else { return nil }
            footerView.doneButton.removeTarget(nil, action: nil, for: .allTouchEvents)
            footerView.doneButton.press { [weak self] in
                self?.postReportMument()
            }
            return footerView
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 98
        default:
            return .leastNormalMagnitude
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 148.adjustedH
        case 1:
            return 58
        default:
            return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let selectedCell = reportMumentTV.cellForRow(at: indexPath)! as! ReportMumentTVC
        selectedCell.setData()
        /// 차단하기 선택시
        if indexPath.section == 1 {
            isBlockChecked.toggle()
            return
        }
        
        if indexPath.row == 6 {
            isEtcChecked.toggle()
            self.delegate?.sendIsEtcSelected(isSelected: isEtcChecked)
        }
        
        /// 배열에 같은 값이 있으면 선택 취소한 것이므로 해당 원소 제거
        if let index = selectedCategoryList.firstIndex(of: indexPath.row + 1) {
            selectedCategoryList.remove(at: index)
        }else {
            selectedCategoryList.append(indexPath.row + 1)
        }
    }
}

// MARK: - SendTextViewDelegate
extension ReportMumentVC: sendTextViewDelegate {
    func sendReportContent(content: String) {
        blockReason = content
    }
    
    func sendTextViewState(isEditing: Bool) {
        if isEditing {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = -self.heightOfKeyBoard
                }
            }
        }else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = 0
                }
            }
        }
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nibName
        )
    }
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.heightOfKeyBoard = keyboardRectangle.height
        }
    }
}


// MARK: - UI
extension ReportMumentVC {
    private func setLayout() {
        self.view.addSubviews([reportMumentTV, navigationBarView, reportDoneButton])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100.adjustedH)
        }
        
        reportMumentTV.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).priority(999)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        reportDoneButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().offset(-39)
            $0.height.equalTo(47)
        }
    }
}

// MARK: - NetWork
extension ReportMumentVC {
    private func postReportMument() {
        MumentDetailAPI.shared.postReportMument(mumentId: mumentId, reportCategory: selectedCategoryList, content: blockReason) { networkResult in
            switch networkResult {
            case .success(let statusCode):
                if let statusCode = statusCode as? Int {
                    debugPrint("report",statusCode)
                }
                if self.isBlockChecked {
                    self.postUserBlock()
                }else {
                    if let navigationController = self.navigationController as? BaseNC, let previousVC = navigationController.previousViewController as? BaseVC {
                        navigationController.popViewController(animated: false)
                        
                        if let previousNC = previousVC.navigationController as? BaseNC, let beforePreviousVC = previousNC.previousViewController as? BaseVC {
                            previousNC.popViewController(animated: true)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100)) {
                                beforePreviousVC.showToastMessage(message: "신고가 접수되었습니다.", color: .black)
                            }
                            beforePreviousVC.viewWillAppear(true)
                        }
                        
                    }
                }
                default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func postUserBlock() {
        MumentDetailAPI.shared.postUserBlock(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let statusCode):
                if let statusCode = statusCode as? Int {
                    debugPrint("block",statusCode)
                }
                if let navigationController = self.navigationController as? BaseNC, let previousVC = navigationController.previousViewController as? BaseVC {
                    navigationController.popViewController(animated: false)
                    
                    if let previousNC = previousVC.navigationController as? BaseNC, let beforePreviousVC = previousNC.previousViewController as? BaseVC {
                        previousNC.popViewController(animated: true)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100)) {
                            beforePreviousVC.showToastMessage(message: "신고 및 차단이 완료되었습니다.", color: .black)
                        }
                        beforePreviousVC.viewWillAppear(true)
                    }
                    
                }
            default:
                if let navigationController = self.navigationController as? BaseNC, let previousVC = navigationController.previousViewController as? BaseVC {
                    navigationController.popViewController(animated: false)
                    
                    if let previousNC = previousVC.navigationController as? BaseNC, let beforePreviousVC = previousNC.previousViewController as? BaseVC {
                        previousNC.popViewController(animated: true)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100)) {
                            beforePreviousVC.makeAlert(title: MessageType.reportUserBlockError.message)
                        }
                        beforePreviousVC.viewWillAppear(true)
                    }
                    
                }
            }
        }
    }
}
