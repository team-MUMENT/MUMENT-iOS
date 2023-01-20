//
//  AllMumentEmptyView.swift
//  MUMENT
//
//  Created by 김담인 on 2023/01/20.
//

import UIKit
import SnapKit
import Then

final class AllMumentEmptyTVC: UITableViewCell {
    
    // MARK: - Components
    private let emptyViewImage = UIImageView().then {
        $0.image = UIImage(named: "allMumentEmptyIcn")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "아직 뮤멘트가 없어요."
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "가장 먼저 뮤멘트를 남겨보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setLayout() {
        self.addSubviews([emptyViewImage, titleLabel, subTitleLabel])
        
        emptyViewImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(76.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(135)
            $0.height.equalTo(109)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyViewImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
