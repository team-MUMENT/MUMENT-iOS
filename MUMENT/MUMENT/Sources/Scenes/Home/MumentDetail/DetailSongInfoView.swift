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
        $0.distribution = .fillProportionally
        $0.alignment = .center
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
    func setData(_ cellData: MumentDetailVCModel){
        albumImage.image = cellData.albumImage
        titleLabel.text = cellData.songtitle
        artistLabel.text = cellData.artist
    }
    
    func setData(albumURL: String,songTitle: String, artist: String){
        albumImage.setImageUrl(albumURL)
        titleLabel.text = songTitle
        artistLabel.text = artist
    }
    
    func setData(_ cellData: HistoryResponseModel.DataMusic){
        albumImage.setImageUrl(cellData.image)
        titleLabel.text = cellData.name
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension DetailSongInfoView {
    
    private func setLayout() {
        self.addSubviews([albumImage,titleStackView,artistLabel])
        
        albumImage.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.height.width.equalTo(55)
        }
        
        titleStackView.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        artistLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(3)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
        
        rightArrowImage.snp.makeConstraints{
            $0.height.equalTo(10)
            $0.width.equalTo(6)
        }
    }
}

