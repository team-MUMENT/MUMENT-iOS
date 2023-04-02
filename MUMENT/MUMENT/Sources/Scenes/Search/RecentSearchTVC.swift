//
//  RecentSearchTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class RecentSearchTVC: UITableViewCell {
    
    // MARK: - Properties
    private let albumImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.font = .mumentB4M14
        $0.textColor = .mBlack1
    }
    private let artistLabel = UILabel().then {
        $0.font = .mumentB8M12
        $0.textColor = .mGray1
    }
    let removeButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentDelete"), for: .normal)
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
        self.setUI()
        self.selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: SearchResultResponseModelElement) {
        self.albumImageView.setImageColor(color: .mGray5)
        self.albumImageView.setImageUrl(data.image ?? APIConstants.defaultProfileImageURL)
        self.titleLabel.text = data.name
        self.artistLabel.text = data.artist
    }
}

// MARK: - UI
extension RecentSearchTVC {
    private func setLayout() {
        self.contentView.addSubviews([albumImageView, titleLabel, artistLabel, removeButton])
        
        self.albumImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(albumImageView.snp.height)
        }
        
        self.removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalTo(albumImageView)
            $0.width.height.equalTo(48)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.top).inset(3)
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(self.removeButton.snp.leading)
        }
        
        self.artistLabel.snp.makeConstraints {
            $0.bottom.equalTo(albumImageView.snp.bottom).inset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(self.removeButton.snp.leading)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}

