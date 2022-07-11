//
//  CarouselCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class CarouselCVC: UICollectionViewCell {

    // MARK: - Properties
    lazy var pageButton = UIButton().then{
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
        $0.setTitleColor(.systemGray2, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    private let headerLable = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    
    private let albumImage = UIImageView().then{
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
    
    private let songTitleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let artistLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - Functions
    func setData(_ cellData: CarouselModel,index: Int){
        self.backgroundColor = cellData.color
        headerLable.text = cellData.headerTitle
        albumImage.image = cellData.albumImage
        songTitleLabel.text = cellData.songTitle
        artistLabel.text = cellData.artistName
        pageButton.setTitle("    \(index) / 3 >  ", for: .normal)
    }
}

// MARK: - UI
extension CarouselCVC {
    
    private func setLayout() {
        self.addSubviews([headerLable,albumImage,songTitleLabel,artistLabel,pageButton])
        
        headerLable.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(140)
        }
        
        albumImage.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(42)
            $0.top.equalTo(headerLable.snp.bottom).offset(70)
            $0.width.height.equalTo(90)
        }
        
        songTitleLabel.snp.makeConstraints{
            $0.top.equalTo(headerLable.snp.bottom).offset(70)
            $0.leading.equalTo(albumImage.snp.trailing).offset(20)
        }
        
        artistLabel.snp.makeConstraints{
            $0.top.equalTo(songTitleLabel.snp.bottom).offset(9)
            $0.leading.equalTo(albumImage.snp.trailing).offset(20)
        }
        
        pageButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(38)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(26)
        }
    }
}

