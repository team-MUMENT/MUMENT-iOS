//
//  SearchTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class SearchTVC: UITableViewCell {
    
    // MARK: - Properties
    private let albumImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.font = .mumentB4M14
        $0.textColor = .mBlack1
    }
    private let artistLabel = UILabel().then {
        $0.font = .mumentB4M14
        $0.textColor = .mBlack1
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: MusicForSearchModel) {
        albumImageView.setImageColor(color: .mGray5)
        albumImageView.setImageUrl(data.imageUrl)
        titleLabel.text = data.title
        artistLabel.text = data.artist
    }
}

// MARK: - UI
extension SearchTVC {
    private func setLayout() {
        self.contentView.addSubviews([albumImageView, titleLabel, artistLabel])
        
        albumImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(albumImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.top).inset(3)
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
        }
        
        artistLabel.snp.makeConstraints {
            $0.bottom.equalTo(albumImageView.snp.bottom).inset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
