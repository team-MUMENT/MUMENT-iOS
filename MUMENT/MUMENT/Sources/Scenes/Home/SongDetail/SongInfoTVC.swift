//
//  SongInfoTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/19.
//

import UIKit
import SnapKit
import Then

final class SongInfoTVC: UITableViewCell {
    
    // MARK: - Properties
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 7)
        $0.clipsToBounds = true
    }
    lazy var songInfoStackView = UIStackView(arrangedSubviews: [titleLabel, artistLabel]).then{
        $0.axis = .vertical
        $0.spacing = 10
        
    }
    private let titleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }
    private let artistLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB4M14
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        selectionStyle = .none
        self.backgroundColor = .mBgwhite
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setData(_ cellData: MusicDto){
        albumImage.setImageUrl(cellData.albumUrl ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        titleLabel.text = cellData.musicTitle
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension SongInfoTVC {
    
    private func setLayout() {
        self.addSubviews([albumImage,songInfoStackView])
        
        albumImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(27)
            $0.height.width.equalTo(114)
            
        }
        
        songInfoStackView.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(15)
            $0.top.equalToSuperview().offset(27)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
