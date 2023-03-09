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
        $0.alignment = .center
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setVersionLabel(currentVersion: String, latestVersion: String) {
        self.versionLabel.text = "현재버전 v\(currentVersion) / 최신버전 v\(latestVersion)"
        self.sizeToFit()
    }
    
    private func setButtonTitle() {
        self.signOutButton.setTitle("로그아웃", for: .normal)
        self.withDrawButton.setTitle("회원탈퇴", for: .normal)
    }
    
    func setSignOutAction(_ closure: @escaping () -> Void) {
        self.signOutButton.removeTarget(nil, action: nil, for: .allEvents)
        self.signOutButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
    
    func setWithDrawAction(_ closure: @escaping () -> Void) {
        self.withDrawButton.removeTarget(nil, action: nil, for: .allEvents)
        self.withDrawButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
}

// MARK: - UI
extension MypageMainFooterTVC {
    private func setLayout() {
        self.addSubviews([buttonStackView, versionLabel])
        self.buttonStackView.addArrangedSubviews([signOutButton, withDrawButton])
        
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        self.versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-5)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
