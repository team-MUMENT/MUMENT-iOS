//
//  RecentSearchEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit

class RecentSearchEmptyView: UIView {
    
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "recentSearchEmpty")
    }
    private let titleLabel = UILabel().then {
        $0.text = """
좋아하는 곡에 대한
다양한 감상을 찾아보세요.
"""
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.sizeToFit()
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "아티스트, 곡을 검색해 보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    private let contentStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setLayout()
        self.setStackView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
    }
    
    private func setStackView() {
        self.contentStackView.addArrangedSubviews([imageView, titleLabel, subTitleLabel])
        
        self.contentStackView.setCustomSpacing(12, after: self.imageView)
        self.contentStackView.setCustomSpacing(8, after: self.titleLabel)
    }
}

// MARK: - UI
extension RecentSearchEmptyView {
    private func setLayout() {
        self.addSubviews([contentStackView])
        
        self.imageView.snp.makeConstraints {
            $0.width.equalTo(135)
            $0.height.equalTo(109)
        }
        
        self.contentStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20).priority(750)
        }
    }
    
    func setUIForBottonSheet() {
        imageView.image = UIImage(named: "mumentHeadSetEmptyRecentSearch")
        titleLabel.text = "감상을 남기고 싶은 곡을 찾아보세요."
        titleLabel.sizeToFit()
    }
}
