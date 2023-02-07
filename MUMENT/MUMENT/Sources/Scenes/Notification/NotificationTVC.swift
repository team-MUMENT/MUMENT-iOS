//
//  NotificationTVC.swift
//  MUMENT
//
//  Created by madilyn on 2023/01/21.
//

import UIKit
import SnapKit
import Then

final class NotificationTVC: UITableViewCell {
    
    enum NotificationType: String {
        case like = "like"
        case notice = "notice"
    }
    
    // MARK: Components
    private let iconImageView = UIImageView().then {
        $0.image = UIImage()
        $0.contentMode = .scaleAspectFit
    }
    
    private let contentLabel = UILabel().then {
        $0.textColor = .mBlack1
        $0.font = .mumentB6M13
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 3
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = .mGray1
        $0.font = .mumentC2R12
    }
    
    let deleteButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "NotificationMumentDelete")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setData(data: GetNotificationListResponseModelElement) {
        if let type = NotificationType(rawValue: data.type) {
            switch type {
            case .like:
                self.iconImageView.image = UIImage(named: "heartSmall")
                if let nickname = data.like.userName,
                   let songTitle = data.like.music.name {
                    self.setLikeNotificationLabel(nickname: nickname, songTitle: songTitle)
                }
            case .notice:
                self.iconImageView.image = UIImage(named: "mumentNotiSmall")
                if let content = data.notice.title {
                    self.setNoticeNotificationLabel(version: data.notice.point, content: content)
                }
            }
            
            self.dateLabel.text = data.createdAt
        }
    }
    
    private func setLikeNotificationLabel(nickname: String, songTitle: String) {
        self.contentLabel.text = "\(nickname)님이 \(songTitle)에 쓴 뮤멘트를 좋아합니다."
        self.contentLabel.setFontColor(to: nickname, font: .mumentB6M13, color: .mBlue1)
        self.contentLabel.setFontColor(to: songTitle, font: .mumentB5B13, color: .mBlack1)
    }
    
    private func setNoticeNotificationLabel(version: String?, content: String) {
        if version == nil {
            self.contentLabel.text = "\(content)"
        } else {
            if let versionText = version {
                self.contentLabel.text = "\(versionText) \(content)"
            }
        }
    }
}

// MARK: - UI
extension NotificationTVC {
    private func setUI () {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubviews([iconImageView, deleteButton, contentLabel, dateLabel])
        
        self.iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(17)
            make.width.height.equalTo(24)
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(14)
            make.width.height.equalTo(24)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.top)
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self.deleteButton.snp.leading).offset(-15)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.contentLabel)
            make.height.equalTo(13)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
