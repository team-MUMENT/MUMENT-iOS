//
//  HeaderTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class TVHeader: DefaultNavigationView {
    
    lazy var titleLabel = UILabel().then{
        $0.text = "Header"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
}

// MARK: - UI
extension TVHeader {
    
    private func setLayout() {
        self.addSubviews([titleLabel])
        backgroundColor = .systemPurple
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(42)
//                    $0.width.height.equalTo(90)
                }
        
    }
}
