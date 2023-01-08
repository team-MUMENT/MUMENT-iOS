//
//  MypageNoticeTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import UIKit
import SnapKit
import Then

final class MypageNoticeTVC: UITableViewCell {
    
    // MARK: Components
    private let labelStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
    }
    
    private let createdAtLabel: UILabel = UILabel().then {
        $0.font = .mumentC1R12
        $0.textColor = .mGray1
    }
    
    private let rightArrowImageView: UIImageView = UIImageView(image: UIImage(named: "mumentBack2")?.withRenderingMode(.alwaysOriginal))
    
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
    func setData(data: GetNoticeListResponseModelElement) {
        self.titleLabel.text = data.title
        self.titleLabel.sizeToFit()
        
        self.createdAtLabel.text = data.createdAt
        self.createdAtLabel.sizeToFit()
    }
}

// MARK: - UI
extension MypageNoticeTVC {
    private func setLayout() {
        self.addSubviews([labelStackView, rightArrowImageView])
        self.labelStackView.addArrangedSubviews([titleLabel, createdAtLabel])
        
        self.labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(283)
        }
        
        self.rightArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.labelStackView)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
