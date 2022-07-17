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
        //        $0.configuration = .plain()
        $0.makeRounded(cornerRadius: 15)
        $0.backgroundColor = .mGray1
        $0.layer.opacity = 0.7
        $0.setTitleColor(.mWhite, for: .normal)
        $0.titleLabel?.font = .mumentC1R12
    }
    
    private let headerLable = UILabel().then{
        $0.textColor = .white
        $0.font = .mumentH1B25
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
    }
    
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 9)
        $0.clipsToBounds = true
    }
    
    private let songTitleLabel = UILabel().then{
        $0.textColor = .white
        $0.font = .mumentB4M14
        
    }
    
    private let artistLabel = UILabel().then{
        $0.textColor = .white
        $0.font = .mumentB8M12
    }
    
    private let backgroundImage = UIImageView()
    
    // MARK: - Initialization
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
        backgroundImage.image = cellData.bannerImage
        headerLable.text = cellData.headerTitle
        albumImage.image = cellData.albumImage
        songTitleLabel.text = cellData.songTitle
        artistLabel.text = cellData.artistName
        pageButton.setTitle("   \(index) / 3 >  ", for: .normal)
    }
}

// MARK: - UI
extension CarouselCVC {
    
    private func setLayout() {
        self.backgroundView = backgroundImage
        self.addSubviews([pageButton,headerLable,albumImage,songTitleLabel,artistLabel])
        
        pageButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
//            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(26)
        }
        
        headerLable.snp.makeConstraints{
            $0.top.equalTo(pageButton.snp.bottom).offset(15)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(147)
        }
        
        albumImage.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(headerLable.snp.bottom).offset(70)
            $0.width.height.equalTo(40)
        }
        
        songTitleLabel.snp.makeConstraints{
            $0.top.equalTo(headerLable.snp.bottom).offset(70)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
        
        artistLabel.snp.makeConstraints{
            $0.top.equalTo(songTitleLabel.snp.bottom).offset(9)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
    }
}

