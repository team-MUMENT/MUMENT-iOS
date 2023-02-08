//
//  ReportMumentTVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

final class ReportMumentTVC: UITableViewCell {
    
    // MARK: - Components
    private let checkButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentReportSelectedBtn"), for: .disabled)
        $0.setImage(UIImage(named: "mumentReportUnselectedBtn"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private let categoryTitleLabel = UILabel().then {
        $0.font = .mumentB3M14
        $0.textColor = .mBlack1
    }
    
    private let categorySubTitleLabel = UILabel().then {
        $0.font = .mumentC1R12
        $0.textColor = .mGray1
        $0.text = "신고하는 사용자의 뮤멘트를 더 이상 보고 싶지 않아요."
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func configure() {
        self.backgroundColor = .mBgwhite
        self.isSelected = false
        self.checkButton.isEnabled = true
    }
    
    func setData() {
        self.checkButton.isEnabled.toggle()
    }
    
    func setCategoryTitle(title: String) {
        self.categoryTitleLabel.text = title
    }
    
    func setBlockCell() {
        self.checkButton.setImage(UIImage(named: "mumentChecked"), for: .disabled)
        self.checkButton.setImage(UIImage(named: "mumentUnchecked"), for: .normal)
        self.categoryTitleLabel.text = "차단하기"
        
        self.addSubview(categorySubTitleLabel)
        
        checkButton.snp.updateConstraints {
            $0.height.width.equalTo(20)
        }
        
        categorySubTitleLabel.snp.updateConstraints {
            $0.leading.equalTo(categoryTitleLabel.snp.leading)
            $0.top.equalTo(categoryTitleLabel.snp.bottom).offset(3)
        }
    }

    private func setLayout() {
        self.addSubviews([checkButton, categoryTitleLabel])
        
        checkButton.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        categoryTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(12)
            $0.centerY.equalTo(checkButton)
        }
    }
}
