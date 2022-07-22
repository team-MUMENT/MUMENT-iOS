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
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "아티스트, 곡을 검색해 보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
    }
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
    }
}

// MARK: - UI
extension RecentSearchEmptyView {
    private func setLayout() {
        self.addSubviews([imageView, titleLabel, subTitleLabel])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(135.adjustedW)
            $0.height.equalTo(109.adjustedW)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setUIForBottonSheet() {
        imageView.image = UIImage(named: "mumentHeadSetEmptyRecentSearch")
        titleLabel.text = "감상을 남기고 싶은 곡을 찾아보세요."
    }
}
