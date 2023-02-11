//
//  MyMumentSectionHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

final class MyMumentSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private let titleLabel = UILabel().then{
        $0.text = "내가 기록한 뮤멘트"
        $0.textColor = .mBlack2
        $0.font = .mumentB1B15
    }
    
    let historyButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.imagePlacement = .trailing
        $0.setAttributedTitle(NSAttributedString(string: "나의 히스토리 보기 >", attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mPurple1
        ]), for: .normal)
    }
    
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Function
    func removeHistoryButton() {
        historyButton.removeFromSuperview()
    }
}

// MARK: - UI
extension MyMumentSectionHeader {
    
    private func setLayout() {
        contentView.addSubviews([titleLabel,historyButton])
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(50.adjustedH)
        }
        
        historyButton.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
