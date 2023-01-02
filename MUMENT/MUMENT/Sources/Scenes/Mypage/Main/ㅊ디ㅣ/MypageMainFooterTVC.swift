//
//  MypageMainFooterTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import SnapKit
import Then

final class MypageMainFooterTVC: UITableViewCell {
    
    // MARK: Components
    private let versionLabel: UILabel = UILabel().then {
        $0.font = .mumentB8M12
        $0.textColor = .mGray1
    }
    
    private let buttonStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 80
    }
    
    private let signOutButton: MumentUnderLineButton = MumentUnderLineButton(type: .system)
    private let withDrawButton: MumentUnderLineButton = MumentUnderLineButton(type: .system)
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setButtonTitle()
        self.setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: Methods
    func setVersionLabel(version: String) {
        self.versionLabel.text = "버전 정보 \(version) v"
        self.sizeToFit()
    }
    
    private func setButtonTitle() {
        self.signOutButton.setTitle("로그아웃", for: .normal)
        self.withDrawButton.setTitle("회원탈퇴", for: .normal)
    }
    
    func setSignOutAction(_ closure: @escaping () -> Void) {
        self.signOutButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
    
    func setWithDrawAction(_ closure: @escaping () -> Void) {
        self.withDrawButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
}

// MARK: - UI
extension MypageMainFooterTVC {
    private func setLayout() {
        self.addSubviews([buttonStackView, versionLabel])
        self.buttonStackView.addArrangedSubviews([signOutButton, withDrawButton])
        
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        self.versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-13)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
