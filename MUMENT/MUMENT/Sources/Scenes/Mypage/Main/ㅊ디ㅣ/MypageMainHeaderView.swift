//
//  MypageMainHeaderView.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import SnapKit
import Then

final class MypageMainHeaderView: UIView {
    
    // MARK: Properties
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .mumentB5B13
        $0.textColor = .mGray2
    }
    
    // MARK: Initialization
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(text: title)
        self.setLayout()
        self.setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: Methods
    private func setTitle(text: String) {
        self.titleLabel.text = text
        self.titleLabel.sizeToFit()
    }
}

// MARK: - UI
extension MypageMainHeaderView {
    private func setLayout() {
        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
