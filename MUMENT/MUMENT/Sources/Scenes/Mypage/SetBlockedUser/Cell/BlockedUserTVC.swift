//
//  BlockedUserTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/07.
//

import UIKit
import SnapKit

final class BlockedUserTVC: UITableViewCell {
    
    // MARK: Components
    private let profileImageView: UIImageView = {
        let profileImageView: UIImageView = UIImageView()
        profileImageView.makeRounded(cornerRadius: 30)
        return profileImageView
    }()
    
    private let nicknameLabel: UILabel = {
        let nicknamelabel: UILabel = UILabel()
        nicknamelabel.font = .mumentH4M16
        nicknamelabel.textColor = .mBlack1
        return nicknamelabel
    }()
    
    let unblockButton: UIButton = {
        let unblockButton: UIButton = UIButton()
        unblockButton.makeRounded(cornerRadius: 6)
        unblockButton.setBackgroundColor(UIColor.mPurple1, for: UIControl.State.normal)
        unblockButton.setTitleWithCustom("해제", font: UIFont.mumentB7B12, color: UIColor.mWhite, for: UIControl.State.normal)
        return unblockButton
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setLayout()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setData(data: GetBlockedUserListResponseModelElement) {
        self.profileImageView.setImageUrl(data.image)
        self.nicknameLabel.text = data.nickname
    }
}

// MARK: - UI
extension BlockedUserTVC {
    private func setLayout() {
        self.addSubviews([profileImageView, nicknameLabel, unblockButton])
        
        self.profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(self.profileImageView.snp.height)
        }
        
        self.unblockButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(self.unblockButton.snp.height).multipliedBy(2.5)
        }
        
        self.nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self.unblockButton.snp.leading).offset(-10)
        }
    }
    
    private func setUI() {
        self.backgroundColor = UIColor.mBgwhite
    }
}
