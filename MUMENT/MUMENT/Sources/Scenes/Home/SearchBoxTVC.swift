//
//  SearchBoxTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class SearchBoxTVC: UITableViewCell {
    
    // MARK: - Properties
    lazy var titleLabel = UILabel().then{
        $0.text = "SearchBox"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    // MARK: - Initialization
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
extension SearchBoxTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel])
        
        backgroundColor = .systemIndigo
        selectionStyle = .none
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(42)
        }
        
    }
}
