//
//  MumentActionSheetVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/15.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MumentActionSheetVC: BaseVC {
    
    // MARK: Components
    let actionTableView: UITableView = UITableView().then {
        $0.rowHeight = 64
        $0.separatorStyle = .none
        $0.layer.cornerRadius = 11
    }
    private let cancelButton: UIButton = UIButton(type: .system).then {
        $0.setTitleWithCustom("취소", font: .mumentH4M16, color: .mBlack2, for: .normal)
        $0.setBackgroundColor(.mWhite, for: .normal)
        $0.layer.cornerRadius = 11
    }
    
    // MARK: Properties
    private var actionName: [String] = []
    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Initialization
    init(actionName: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        self.actionName = actionName
        self.setActionTableView()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setCancelButtonAction()
    }
    
    // MARK: Functions
    private func setActionTableView() {
        actionTableView.register(cell: MumentActionSheetTVC.self, forCellReuseIdentifier: MumentActionSheetTVC.className)
        let items = Observable.just(actionName)
        
        items.bind(to: actionTableView.rx.items) { (tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentActionSheetTVC.className) as? MumentActionSheetTVC else { return UITableViewCell() }
            cell.setTitleLabel(titleText: element)
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    private func setCancelButtonAction() {
        cancelButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - UI
extension MumentActionSheetVC {
    private func setUI() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = .mAlertBgBlack.withAlphaComponent(0.65)
    }
    
    private func setLayout() {
        self.view.addSubviews([actionTableView, cancelButton])
        
        cancelButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(60)
        }
        
        actionTableView.snp.makeConstraints {
            $0.left.right.equalTo(cancelButton)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-15)
            $0.height.equalTo(64 * actionName.count)
        }
    }
}
