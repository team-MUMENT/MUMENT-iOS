//
//  SongDetailMyMumentEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/22.
//

import UIKit

class SongDetailMyMumentEmptyTVC: UITableViewCell {
    
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.text = """
아직 뮤멘트가 없어요.
"""
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "첫 뮤멘트를 남겨보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
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
}

extension SongDetailMyMumentEmptyTVC {
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
    
    private func setLayout() {
        self.addSubviews([titleLabel, subTitleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(5.adjustedH)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.adjustedH)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
