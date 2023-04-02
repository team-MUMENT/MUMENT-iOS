//
//  MypageMainSeparatorView.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/29.
//

import UIKit
import SnapKit
import Then

final class MypageMainSeparatorView: UIView {
    
    // MARK: Components
    private let separator: UIView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    
    // MARK: Initialization
    init(type: MypageMainVC.Section) {
        super.init(frame: .zero)
        
        self.setLayout(type: type)
        self.setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

// MARK: - UI
extension MypageMainSeparatorView {
    private func setLayout(type: MypageMainVC.Section) {
        self.addSubview(separator)
        
        let separatorTopSpacing = type == .profile ? 0 : 8
        
        self.separator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(separatorTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
