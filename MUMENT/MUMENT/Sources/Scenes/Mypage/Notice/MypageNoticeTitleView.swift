//
//  MypageNoticeTitleView.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import UIKit
import SnapKit
import Then

final class MypageNoticeTitleView: UIView {
    
    // MARK: Components
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
    }
    
    private let createdAtLabel: UILabel = UILabel().then {
        $0.font = .mumentC1R12
        $0.textColor = .mGray1
    }
    
    private let separator: UIView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
extension MypageNoticeTitleView {
    private func setLayout() {
        self.addSubviews([titleLabel, createdAtLabel, separator])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.separator.snp.makeConstraints {
            $0.top.equalTo(self.createdAtLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
