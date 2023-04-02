//
//  ReportDoneButtonFooterView.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/14.
//

import UIKit
import SnapKit

final class ReportDoneButtonFooterView: UITableViewHeaderFooterView {
    
    // MARK: Components
    let doneButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("신고하기", for: .normal)
    }
    
    // MARK: Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDoneButtonStatus(isEnabled: Bool) {
        self.doneButton.isEnabled = isEnabled
    }
}

// MARK: - UI
extension ReportDoneButtonFooterView {
    private func setLayout() {
        self.contentView.addSubview(self.doneButton)
        
        self.doneButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-39)
            $0.height.equalTo(47)
        }
    }
}
