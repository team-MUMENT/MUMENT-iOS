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
    
    // MARK: Components
    private let iconImageView = UIImageView().then {
        $0.image = UIImage()
        $0.contentMode = .scaleAspectFit
    }
    
    private let contentLabel = UILabel().then {
        $0.textColor = .mBlack1
        $0.font = .mumentB6M13
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = .mGray1
        $0.font = .mumentC2R12
    }
    
    private let deleteButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentDelete"), for: .normal)
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
            make.trailing.equalTo(self.deleteButton.snp.leading).offset(15)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.contentLabel)
            make.height.equalTo(13)
        }
    }
}
