//
//  LikedUserListTVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/05.
//

import UIKit
import SnapKit
import Then

final class LikedUserListTVC: UITableViewCell {

    // MARK: - Components
    private let profileImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 22.5)
        $0.contentMode = .scaleAspectFill
    }
    
    private let userNickNameLabel = UILabel().then {
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLikedUserData(userData: LikedUserListResponseModel) {
        self.profileImageView.setImageUrl(userData.image ?? "")
        self.userNickNameLabel.text = userData.profileId
    }
}

// MARK: - UI
extension LikedUserListTVC {
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
    
    private func setLayout() {
        self.addSubviews([profileImageView, userNickNameLabel])
        
        profileImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(45)
        }
        
        userNickNameLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(15)
            $0.centerY.equalTo(profileImageView)
        }
    }
}
