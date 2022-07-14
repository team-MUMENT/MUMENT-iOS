//
//  SongInfoCell.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class DetailSongInfoView: UIView {
    
    // MARK: - Properties
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 7)
        $0.clipsToBounds = true
    }

    lazy var titleStackView = UIStackView(arrangedSubviews: [titleLabel, rightArrowImage]).then{
        $0.axis = .horizontal
        $0.spacing = 6
        
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
    func setData(_ cellData: SongDetailInfoModel){
        albumImage.image = cellData.albumImage
        titleLabel.text = cellData.songtitle
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension DetailSongInfoView {
    
    private func setLayout() {
        self.addSubviews([albumImage,titleStackView,artistLabel])
        
        albumImage.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(11)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.height.width.equalTo(55)
        }
        
        titleStackView.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
        }
        
        artistLabel.snp.makeConstraints{            $0.top.equalTo(titleStackView.snp.bottom).offset(3)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
    }
}

