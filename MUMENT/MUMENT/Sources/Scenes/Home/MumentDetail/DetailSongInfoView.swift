//
//  SongInfoCell.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

final class DetailSongInfoView: UIView {
    
    // MARK: - Components
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 7)
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentB2B14
    }
    private let rightArrowImage = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")
    }
    private let artistLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
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
    
    //MARK: - Functions
    func setData(_ data: MusicDTO){
        albumImage.setImageUrl(data.albumUrl)
        titleLabel.text = data.title
        artistLabel.text = data.artist
        titleLabel.sizeToFit()
    }
}

// MARK: - UI
extension DetailSongInfoView {
    
    private func setLayout() {
        self.addSubviews([albumImage, titleLabel, rightArrowImage, artistLabel])
        
        albumImage.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.height.width.equalTo(55)
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(19)
        }
        rightArrowImage.snp.makeConstraints{
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.trailing.greaterThanOrEqualToSuperview().priority(300)
            $0.top.equalToSuperview().offset(25)
            $0.height.equalTo(10)
            $0.width.equalTo(6)
        }
        artistLabel.snp.makeConstraints{
            $0.top.equalTo(rightArrowImage.snp.bottom).offset(3)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
    }
}

