//
//  MumentForTodayTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class MumentForTodayTVC: UITableViewCell {
    
    lazy var titleLabel = UILabel().then{
        $0.text = "MumentForToday"
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
extension MumentForTodayTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel])
        backgroundColor =  .systemMint
        selectionStyle = .none
       titleLabel.snp.makeConstraints{
        $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(42)
//            $0.top.equalTo(headerLable.snp.bottom).offset(70)
//            $0.width.height.equalTo(90)
    }
        
    }
}
