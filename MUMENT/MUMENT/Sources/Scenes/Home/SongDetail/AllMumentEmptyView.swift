//
//  AllMumentEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/15.
//

import UIKit
import SnapKit
import Then

final class AllMumentEmptyView: UIView {
    
    // MARK: Components
    private let emptyViewImage = UIImageView().then {
        $0.image = UIImage(named: "allMumentEmptyIcn")
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.text = "아직 뮤멘트가 없어요."
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.sizeToFit()
    }
    private let subTitleLabel: UILabel = UILabel().then {
        $0.text = "가장 먼저 뮤멘트를 남겨보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension AllMumentEmptyView {
    private func setUI() {
        self.backgroundColor = .mBgwhite
        self.isUserInteractionEnabled = false
    }
    
    private func setLayout() {
        self.stackView.addArrangedSubviews([emptyViewImage, titleLabel, subTitleLabel])
        
        self.emptyViewImage.snp.makeConstraints {
            $0.width.equalTo(135)
            $0.height.equalTo(109)
        }
        
        self.stackView.setCustomSpacing(20, after: self.emptyViewImage)
        self.stackView.setCustomSpacing(8, after: self.titleLabel)
        
        self.addSubview(stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
}
