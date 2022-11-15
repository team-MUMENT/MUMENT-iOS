//
//  MumentActionSheetTVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/15.
//

import UIKit
import SnapKit
import Then

final class MumentActionSheetTVC: UITableViewCell {
    
    // MARK: Components
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .mumentH4M16
        $0.textColor = .mBlack2
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleLabel(titleText: String) {
        titleLabel.text = titleText
        titleLabel.sizeToFit()
    }
}

// MARK: - UI
extension MumentActionSheetTVC {
    private func setLayout() {
        tintColor = .white
        backgroundColor = .white
        
        addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}
