//
//  SearchResultEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/16.
//

import UIKit
import SnapKit
import Then

class SearchResultEmptyView: UIView {
    
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "mumentAlertIcn")
    }
    private let titleLabel = UILabel().then {
        $0.text = """
에 대한
검색 결과가 없어요.
"""
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "다른 검색어를 입력해 보세요."
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
    
    func setSearchKeyword(keyword: String) {
        titleLabel.text = """
\(keyword)에 대한
검색 결과가 없어요.
"""
    }
}

// MARK: - UI
extension SearchResultEmptyView {
    private func setLayout() {
        self.addSubviews([imageView, titleLabel, subTitleLabel])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(11)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

