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
    
//    lazy var titleStackView = UIStackView(arrangedSubviews: [titleLabel, rightArrowImage]).then{
//        $0.axis = .horizontal
//        $0.spacing = 6
//        $0.distribution = .fillProportionally
//        $0.alignment = .center
//    }
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
        titleLabel.sizeToFit()
    }
    
    func setData(albumURL: String, songTitle: String, artist: String){
        albumImage.setImageUrl(albumURL)
        titleLabel.text = songTitle
        artistLabel.text = artist
        titleLabel.sizeToFit()
//        titleLabel.adjustsFontSizeToFitWidth = true
//        titleLabel.
    }
    
    func setData(_ cellData: HistoryResponseModel.DataMusic){
        albumImage.setImageUrl(cellData.image ?? "https://avatars.githubusercontent.com/u/25932970?s=88&u=9ceb91d683a7d9cfe968cd35cd07a428536605e6&v=4")
        titleLabel.text = cellData.name
        titleLabel.sizeToFit()
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension DetailSongInfoView {
    
    private func setLayout() {
        self.addSubviews([albumImage,
//                          titleStackView,
                          titleLabel, rightArrowImage, artistLabel])
        
        albumImage.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.height.width.equalTo(55)
        }
        
//        titleStackView.snp.makeConstraints{
//            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
//            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
//            $0.trailing.equalTo(self.safeAreaLayoutGuide)
//        }
//        titleLabel.setContentCompressionResistanceePriority(.init(rawValue: 998), for: .horizontal)
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(19)
            
//            $0.trailing.greaterThanOrEqualToSuperview().inset(6).priority(888)
            
        }
//        rightArrowImage.setContentCompressionResistancePriority(.init(rawValue: 999), for: .horizontal)
        rightArrowImage.snp.makeConstraints{
            
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.trailing.greaterThanOrEqualToSuperview().priority(300)
            
            $0.top.equalToSuperview().offset(25)
//            $0.trailing.equalToSuperview()
            $0.height.equalTo(10)
            $0.width.equalTo(6)
        }
        
        artistLabel.snp.makeConstraints{
            $0.top.equalTo(rightArrowImage.snp.bottom).offset(3)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
    }
}

