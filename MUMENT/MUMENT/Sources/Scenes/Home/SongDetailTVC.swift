//
//  SongDetailTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class SongDetailTVC: UITableViewCell {
    
    // MARK: - Properties
    private let mumentCardView = MumentCardBySongTVC()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
}

// MARK: - UI
extension SongDetailTVC {
    
    private func setLayout() {
        
        self.addSubviews([mumentCardView])
        
        mumentCardView.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)

        }
    }
}
