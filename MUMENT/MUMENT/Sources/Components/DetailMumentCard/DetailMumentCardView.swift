//
//  DetailMumentView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class DetailMumentCardView: UIView {
    
    // MARK: - Properties
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12.5)
    }
    private let writerNameLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentB6M13
    }
//
    private let menuIconButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "kebab")
    }
//
    private let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    
    private let songInfoView = DetailSongInfoView()
    
    ///data에 있는 것 만큼 DefaultTagView()하고 stack view에 추가
    private let tagStackView = UIStackView()
    private let contentsLabel = UILabel().then{
        $0.textColor = .mGray1
        //TODO:
//        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 100
        $0.font = .mumentB4M14
    }
    private let createdAtLabel = UILabel().then{
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    
    lazy var heartStackView = UIStackView(arrangedSubviews: [heartButton, heartLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let heartButton = UIButton().then{
//            $0.setImage(UIImage(named: "leftArrow"), for: .normal)
            $0.configuration = .plain()
        }
    private let heartLabel = UILabel().then{
        $0.font = .mumentC1R12
        $0.textColor = .mGray1
    }
    
    private let shareButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "share")
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        setDefaultUI()
//        setDefaultLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        setDefaultUI()
//        setDefaultLayout()
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentDetailVCModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        songInfoView.setData(cellData)
        contentsLabel.text = cellData.contents
        createdAtLabel.text = cellData.createdAt
        heartLabel.text = "\(cellData.heartCount)명이 좋아합니다."
    }
}

// MARK: - UI
extension DetailMumentCardView {
    
//    func setDefaultUI(){
//        self.backgroundColor = .mWhite
//        self.makeRounded(cornerRadius: 11)
//        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 8.0)
//    }
//
    func setDefaultLayout() {
        self.addSubviews([writerInfoStackView,menuIconButton,separatorView,songInfoView,tagStackView,contentsLabel,createdAtLabel,heartStackView,shareButton])

        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        menuIconButton.snp.makeConstraints{
            $0.top.right.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(38)
        }

        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }

        songInfoView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(7)
            $0.top.equalTo(separatorView.snp.bottom).offset(7)
//            $0.height.width.equalTo(70)
        }
        
        tagStackView.snp.makeConstraints{
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        contentsLabel.snp.makeConstraints{
            $0.top.equalTo(tagStackView.snp.bottom).offset(22)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        createdAtLabel.snp.makeConstraints{
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
//            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        heartStackView.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.left.equalTo(self.safeAreaLayoutGuide)
        }

        shareButton.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.right.equalTo(self.safeAreaLayoutGuide)
        }
//
//        historyButton.snp.makeConstraints{
//            $0.left.equalTo(albumImage.snp.right).offset(10)
//            $0.top.equalTo(songInfoStackView.snp.bottom).offset(7)
//        }
//
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
    }
}

