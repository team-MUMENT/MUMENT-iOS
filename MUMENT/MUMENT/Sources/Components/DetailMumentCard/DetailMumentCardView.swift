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
    
    let menuIconButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "kebab")
    }
    
    private let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    
    let songInfoView = DetailSongInfoView()
    
    var isFirst: Bool = false
    var impressionTags: [Int] = []
    var feelingTags: [Int] = []
    var tagWidthSum: CGFloat = 0
    let tagStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    let tagSubStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let contentsLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 100
        $0.font = .mumentB4M14
    }
    private let createdAtLabel = UILabel().then{
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    
    lazy var heartStackView = UIStackView(arrangedSubviews: [heartButton, heartLabel]).then{
        $0.axis = .horizontal
    }
    private let heartButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.buttonSize = .small
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
        setUI()
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentDetailVCModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        songInfoView.setData(cellData)
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTags
        feelingTags = cellData.feelingTags
        contentsLabel.text = cellData.contents
        createdAtLabel.text = cellData.createdAt
        heartButton.setImage(cellData.heartImage, for: .normal)
        heartLabel.text = "\(cellData.heartCount)명이 좋아합니다."
    }
    
    func setData(_ cellData: MumentDetailResponseModel){
        print("들어왓나열?", cellData)
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
        songInfoView.setData(albumURL: cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg", songTitle: cellData.music.name, artist: cellData.music.artist )
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTag
        feelingTags = cellData.feelingTag
        contentsLabel.text = cellData.content
        createdAtLabel.text = cellData.createdAt
        heartButton.setImage(cellData.isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart"), for: .normal)
        heartLabel.text = "\(cellData.count)명이 좋아합니다."
        
        setTags()
    }
    
    func setTags(){
        
        tagStackView.removeAllArrangedSubviews()
        tagSubStackView.removeAllArrangedSubviews()

        let tag = TagView()
        tag.tagType = "isFirst"
        tag.tagContentString = isFirst ? "처음" : "다시"
        tagStackView.addArrangedSubview(tag)
                
        if impressionTags.count != 0{
            for i in 0...impressionTags.count-1{
                let tag = TagView()
                tag.tagContent = impressionTags[i]
                
                if  tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                }else{
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
    }
}

// MARK: - UI
extension DetailMumentCardView {
    
    func setUI(){
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 2.0)
    }
    
    func setLayout() {
        self.addSubviews([writerInfoStackView,menuIconButton,separatorView,songInfoView,tagStackView,tagSubStackView,contentsLabel,createdAtLabel,heartStackView,shareButton])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        menuIconButton.snp.makeConstraints{
            $0.right.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(38)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
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
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(72)
            $0.width.equalTo(144)
        }
        
        tagStackView.snp.makeConstraints{
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        tagSubStackView.snp.makeConstraints{
            $0.top.equalTo(tagStackView.snp.bottom).offset(8)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        contentsLabel.snp.makeConstraints{
            $0.top.equalTo(tagSubStackView.snp.bottom).offset(22)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        createdAtLabel.snp.makeConstraints{
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        heartStackView.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(5)
            
        }
        
        shareButton.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
        
        heartButton.snp.makeConstraints{
            $0.height.width.equalTo(38)
        }
    }
}

