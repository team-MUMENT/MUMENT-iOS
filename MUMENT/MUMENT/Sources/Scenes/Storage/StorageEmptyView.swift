//
//  StorageEmptyView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import UIKit
import SnapKit
import Then

class StorageEmptyView: UIView {
    
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "likedMumentEmptyImage")
    }
    private let titleLabel = UILabel().then {
        $0.text = """
아직 기록한 뮤멘트가 없어요.
"""
        $0.font = .mumentH3B16
        $0.textColor = .mGray1
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "뮤멘트를 남겨 나만의 감상을 언제든 꺼내보세요."
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.textAlignment = .center
    }
    let writeButton = UIButton().then {
        $0.setImage(UIImage(named: "recordBtn2"), for: .normal)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUI()
    }
}

extension StorageEmptyView {
    func setUI() {
        self.backgroundColor = .mBgwhite
    }
    
    func setMyMumentLayout() {
        self.addSubviews([imageView, titleLabel, subTitleLabel])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130.adjustedH)
            $0.width.equalTo(135.adjustedH)
            $0.height.equalTo(109.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalTo(imageView)
            $0.height.equalTo(22)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(titleLabel)
            $0.height.equalTo(20)
        }
    }
    
    func setLikedMumentLayout() {
        titleLabel.text = "아직 좋아요한 뮤멘트가 없어요."
        subTitleLabel.text = "좋아요를 눌러 마음에 든 뮤멘트를 언제든 꺼내보세요."
        
        self.addSubviews([imageView, titleLabel, subTitleLabel])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130.adjustedH)
            $0.width.equalTo(135.adjustedH)
            $0.height.equalTo(109.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalTo(imageView)
            $0.height.equalTo(22)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(titleLabel)
            $0.height.equalTo(20)
        }
    }
    
    func setFilteredLayout() {
        titleLabel.text = "아직 좋아요한 뮤멘트가 없어요."
        subTitleLabel.text = "좋아요를 눌러 마음에 든 뮤멘트를 언제든 꺼내보세요."
        
        self.addSubviews([titleLabel, subTitleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(212.adjustedH)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(titleLabel)
            $0.height.equalTo(20)
        }
    }
}
