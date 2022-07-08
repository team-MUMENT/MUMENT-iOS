//
//  DefaultNavigationView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit
import SnapKit
import Then

class DefaultNavigationView: UIView {
    
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.setLabel(text: "제목", color: .mBlack1, font: .mumentH1Sb25)
        $0.sizeToFit()
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setDefaultLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setDefaultLayout()
    }
}

// MARK: - UI
extension DefaultNavigationView {
    func setDefaultLayout() {
        self.addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    /// 커스텀 네비 바 타이틀 설정하는 메서드
    func setTitleLabel(title: String) {
        self.titleLabel.text = title
    }
}
