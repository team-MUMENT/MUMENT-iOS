//
//  CarouselCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/11.
//

import UIKit
import SnapKit
import Then

protocol CarouselCVCDelegate : AnyObject{
    func carouselCVCSelected(data: CarouselResponseModel.BannerList)
}

class CarouselCVC: UICollectionViewCell {
    
    // MARK: - Properties
    var delegate: CarouselCVCDelegate?
    var pageValue: String = "" {
        didSet{
            let highlitedString = NSAttributedString(string:  pageValue, attributes: [
                .font: UIFont.mumentC1R12,
                .foregroundColor: UIColor.mWhite
            ])
            
            let normalString = NSAttributedString(string:  " / 3 ", attributes: [
                .font: UIFont.mumentC1R12,
                .foregroundColor: UIColor.mGray2
            ])
            
            let title = highlitedString + normalString
            pageButton.setAttributedTitle(title, for: .normal)
        }
    }
    lazy var pageButton = UIButton().then{
        $0.configuration = .plain()
        $0.makeRounded(cornerRadius: 12)
        $0.backgroundColor = .mGray1
        $0.layer.opacity = 0.7
    }
    
    private let headerLable = UILabel().then{
        $0.textColor = .mWhite
        $0.font = .mumentH1B25
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 9)
        $0.clipsToBounds = true
    }
    
    private let songTitleLabel = UILabel().then{
        $0.textColor = .mWhite
        $0.font = .mumentB4M14
        
    }
    
    private let artistLabel = UILabel().then{
        $0.textColor = .mPurple2
        $0.font = .mumentB8M12
    }
    
    private let backgroundImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 15)
    }
    
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
    func setData(_ cellData: CarouselResponseModel.BannerList, index: Int){
        backgroundImage.image = UIImage(named: "mumentBanner\(index)")
        headerLable.text = cellData.tagTitle.replaceNewLineKeyword()
        albumImage.setImageUrl(cellData.music.image)
        songTitleLabel.text = cellData.music.name
        artistLabel.text = cellData.music.artist
        pageValue = "\(index)"
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
            $0.width.equalTo(49)
            $0.height.equalTo(24)
        }
        
        headerLable.snp.makeConstraints{
            $0.top.equalTo(pageButton.snp.bottom).offset(15)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
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
            $0.top.equalTo(songTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
    }
}

