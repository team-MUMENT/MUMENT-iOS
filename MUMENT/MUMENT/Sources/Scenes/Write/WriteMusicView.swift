//
//  WriteMusicView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import UIKit
import SnapKit
import Then

class WriteMusicView: UIView {
    
    // MARK: - Properties
    private let albumImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 5)
        $0.image = UIImage(named: "image3")
    }
    private let titleLabel = UILabel().then {
        $0.text = "노래 제목"
        $0.font = .mumentB2B14
        $0.textColor = .mBlack2
        $0.lineBreakMode = .byTruncatingTail
    }
    private let artistLabel = UILabel().then {
        $0.text = "가수 이름"
        $0.font = .mumentB6M13
        $0.textColor = .mGray1
        $0.lineBreakMode = .byTruncatingTail
    }
    let removeButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentDelete2"), for: .normal)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
        setUI()
    }
}

extension WriteMusicView {
    private func setUI() {
        self.backgroundColor = .mWhite
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mWhite.cgColor
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: .zero, opacity: 0.1, radius: 11)
    }
    
    private func setLayout() {
        self.addSubviews([albumImageView, titleLabel, artistLabel, removeButton])
        
        albumImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(9)
            $0.width.equalTo(albumImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.top).inset(8)
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.right.equalTo(removeButton.snp.left).offset(10)
        }
        
        artistLabel.snp.makeConstraints {
            $0.bottom.equalTo(albumImageView.snp.bottom).inset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalTo(albumImageView)
            $0.width.height.equalTo(24)
        }
    }
    
    func setData(data: SearchResultResponseModelElement) {
        albumImageView.setImageUrl(data.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        titleLabel.text = data.name
        artistLabel.text = data.artist
    }
}
