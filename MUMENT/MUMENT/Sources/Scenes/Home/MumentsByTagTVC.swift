//
//  MumentsByTagTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class MumentsByTagTVC: UITableViewCell {
    
    lazy var titleLabel = UILabel().then{
        $0.text = "MumentsByTag"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension MumentsByTagTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel])
        backgroundColor = .systemGreen
        selectionStyle = .none
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(42)
        }
        
    }
}
