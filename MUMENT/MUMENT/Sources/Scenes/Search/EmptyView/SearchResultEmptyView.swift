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
    
    func setSearchKeyword(keyword: String) {
        let markedKeyword: String = "'\(keyword)'"
        self.titleLabel.text = """
\(markedKeyword)에 대한
검색 결과가 없어요.
"""
        self.titleLabel.setColor(to: markedKeyword, with: .mBlack2)
        self.titleLabel.sizeToFit()
    }
    
    private func setStackView() {
        self.contentStackView.addArrangedSubviews([imageView, titleLabel, subTitleLabel])
        
        self.contentStackView.setCustomSpacing(12, after: self.imageView)
        self.contentStackView.setCustomSpacing(8, after: self.titleLabel)
    }
}

// MARK: - UI
extension SearchResultEmptyView {
    private func setLayout() {
        self.addSubviews([contentStackView])
        
        self.imageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        self.contentStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20).priority(750)
        }
    }
}
