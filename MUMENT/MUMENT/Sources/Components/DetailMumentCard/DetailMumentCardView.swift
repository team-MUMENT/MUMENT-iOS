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
        $0.font = .mumentC1R12
        $0.sizeToFit()
    }
//
    private let menuIconButton = UIButton()
//
    private let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    
    private let songInfoView = DetailSongInfoView()
    
    ///data에 있는 것 만큼 DefaultTagView()하고 stack view에 추가
//    private let tagStackView = UIStackView()
    private let contentsLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 2
        $0.font = UIFont(name: "NotoSans-Medium", size: 13.0)
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
    //        $0.setImage(UIImage(named: "leftArrow"), for: .normal)
            $0.configuration = .plain()
        }
    private let heartLabel = UILabel()
    
    private let shareButton = UIButton()
    private let mumentHistoryButton = UIButton().then{
        $0.makeRounded(cornerRadius: 11)
        $0.backgroundColor = .mGray4
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "rightArrow")
        $0.configuration?.imagePadding = 5
//        $0.setTitle("", for: .normal)
        $0.layer.cornerRadius = 10
        $0.setAttributedTitle(NSAttributedString(string: "뮤멘트 기록하기",attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mGray1
        ]), for: .normal)
        //        $0.contentHorizontalAlignment = .left
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
//    func setData(_ cellData: MumentCardWithoutHeartModel){
//        profileImage.image = cellData.profileImage
//        writerNameLabel.text = cellData.writerName
//        albumImage.image = cellData.albumImage
//        songTitleLabel.text = cellData.songTitle
//        artistLabel.text = cellData.artistName
//        contentsLabel.text = cellData.contentsLabel
//        createdAtLabel.text = cellData.createdAtLabel
//    }
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
        self.addSubviews([writerInfoStackView,menuIconButton,separatorView,songInfoView,contentsLabel,createdAtLabel,heartStackView,shareButton,mumentHistoryButton])

        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        menuIconButton.snp.makeConstraints{
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }

        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }

        songInfoView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.height.width.equalTo(70)
        }

        shareButton.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.right).offset(10)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
        }

        mumentHistoryButton.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.right).offset(10)
            $0.top.equalTo(songInfoStackView.snp.bottom).offset(7)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
    }
}

