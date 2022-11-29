//
//  MypageMainTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import SnapKit
import Then

final class MypageMainTVC: UITableViewCell {
    
    // MARK: Components
    
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
    }
    
    private let rightArrowImageView: UIImageView = UIImageView(image: UIImage(named: "mumentBack2")?.withRenderingMode(.alwaysOriginal))
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Methods
    func setTitle(text: String) {
        self.titleLabel.text = text
        self.titleLabel.sizeToFit()
    }
}

// MARK: - UI
extension MypageMainTVC {
    private func setLayout() {
        self.addSubviews([titleLabel, rightArrowImageView])
        
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.rightArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
