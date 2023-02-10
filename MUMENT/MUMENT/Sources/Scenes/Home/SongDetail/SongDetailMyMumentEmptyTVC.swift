//
//  SongDetailMyMumentEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/22.
//

import UIKit
import SnapKit
import Then

final class SongDetailMyMumentEmptyTVC: UITableViewCell {
    
    // MARK: - Properties
    private let emptyContentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "아직 뮤멘트가 없어요."
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "첫 뮤멘트를 남겨보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
    }
    
    private let labelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SongDetailMyMumentEmptyTVC {
    private func setUI() {
        self.backgroundColor = .mBgwhite
    }
    
    private func setLayout() {
        self.addSubview(emptyContentView)
        self.labelStackView.addArrangedSubviews([titleLabel, subTitleLabel])
        emptyContentView.addSubviews([labelStackView])
        
        emptyContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(184)
        }
        
        self.labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }
}
