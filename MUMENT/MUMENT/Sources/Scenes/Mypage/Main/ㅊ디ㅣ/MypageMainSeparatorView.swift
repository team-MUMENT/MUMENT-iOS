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
    
    // MARK: Properties
    private let separator: UIView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
        self.setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

// MARK: - UI
extension MypageMainSeparatorView {
    private func setLayout() {
        self.addSubview(separator)
        
        self.separator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
}
