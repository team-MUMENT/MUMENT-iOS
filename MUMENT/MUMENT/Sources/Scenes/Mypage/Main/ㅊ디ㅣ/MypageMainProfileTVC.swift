//
//  MypageMainProfileTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import SnapKit
import Then

final class MypageMainProfileTVC: UITableViewCell {
    
    // MARK: Components
    private let profileImageView: UIImageView = UIImageView()
    private let profileStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let profileTitleLabel: UILabel = UILabel().then {
        $0.text = "프로필"
        $0.font = .mumentB5B13
        $0.textColor = .mGray2
        $0.sizeToFit()
    }
    
    private let nicknameLabel: UILabel = UILabel().then {
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
    }
    
    private let rightArrowImageView: UIImageView = UIImageView(image: UIImage(named: "mumentBack2")?.withRenderingMode(.alwaysOriginal))
    
    // MARK: Properties
    private let defaultProfileImageName: [String] = ["mumentProfileLove60", "mumentProfileSleep60", "mumentProfileSmile60"].shuffled()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setLayout()
        self.setDefaultProfileImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setNickname(text: String) {
        self.nicknameLabel.text = text
        self.sizeToFit()
    }
    
    private func setDefaultProfileImage() {
        self.profileImageView.image = UIImage(named: defaultProfileImageName[0])
    }
    
    func setProfileImage(imageURL: String?) {
        if let url = imageURL {
            self.profileImageView.setImageUrl(url)
        }
    }
}

// MARK: - UI
extension MypageMainProfileTVC {
    private func setUI() {
        self.addSubviews([profileImageView, profileStackView, rightArrowImageView])
        
        self.profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(self.profileImageView.snp.height)
        }
        
        self.profileStackView.snp.makeConstraints {
            $0.centerY.equalTo(self.profileImageView)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(10)
        }
        
        self.rightArrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
        
        self.profileStackView.addArrangedSubviews([profileTitleLabel, nicknameLabel])
    }
    
    private func setLayout() {
        self.backgroundColor = .mBgwhite
        DispatchQueue.main.async {
            self.profileImageView.layer.masksToBounds = true
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        }
    }
}
