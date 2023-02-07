//
//  DefaultMumentView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/12.
//
import UIKit
import SnapKit
import Then

class MumentCardWithoutHeartView: UIView {
    
    // MARK: - Properties
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 7
    }
    let profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12.5)
        $0.contentMode = .scaleAspectFill
    }
    let writerNameLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentC1R12
        $0.sizeToFit()
    }
    
    let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 4)
    }
    
    lazy var songInfoStackView = UIStackView(arrangedSubviews: [songTitleLabel, artistLabel]).then{
        $0.axis = .vertical
        $0.spacing = 3
    }
    let songTitleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentB2B14
        $0.lineBreakMode = .byTruncatingTail
    }
    let artistLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
        $0.lineBreakMode = .byTruncatingTail
    }
    
    var isFirst: Bool = false
    var impressionTags: [Int] = []
    var feelingTags: [Int] = []
    let tagStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    let contentsLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 2
        $0.font = .mumentB6M13
    }
    
    let createdAtLabel = UILabel().then{
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setDefaultUI()
        setDefaultLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: Methods
    func setMumentForTodayData(_ cellData: MumentForTodayResponseModel){
        profileImage.setImageUrl(cellData.todayMument.user.image)
        writerNameLabel.text = cellData.todayMument.user.name
        albumImage.setImageUrl(cellData.todayMument.music.image)
        songTitleLabel.text = cellData.todayMument.music.name
        artistLabel.text = cellData.todayMument.music.artist
        contentsLabel.text = cellData.todayMument.content.replaceNewLineKeyword()
        createdAtLabel.text = cellData.todayMument.date
        isFirst = cellData.todayMument.isFirst
        impressionTags = cellData.todayMument.impressionTag
        feelingTags = cellData.todayMument.feelingTag
        setCardTags(cellData.todayMument.cardTag)
    }
    
    func setWithoutHeartData(_ cellData: StorageMumentModel){
        profileImage.setImageUrl(cellData.user.image ?? APIConstants.defaultProfileImageURL)
        writerNameLabel.text = cellData.user.name
        albumImage.setImageUrl(cellData.music.image)
        songTitleLabel.text = cellData.music.name
        artistLabel.text = cellData.music.artist
        contentsLabel.text = cellData.content?.replaceNewLineKeyword()
        createdAtLabel.text = cellData.createdAt
        isFirst = cellData.isFirst
        setCardTags(cellData.cardTag)
    }
    
    func setCardTags(_ indexs: [Int]) {
        let tag = TagView()
        tag.tagType = "isFirst"
        tag.tagContentString = isFirst ? "처음" : "다시"
        tagStackView.removeAllArrangedSubviews()
        tagStackView.addArrangedSubview(tag)
        
        if indexs.count != 0{
            for i in 0...indexs.count-1{
                let tag = TagView()
                tag.tagContent = indexs[i]
                tagStackView.addArrangedSubview(tag)
            }
        }
    }
}

// MARK: - UI
extension MumentCardWithoutHeartView {
    
    func setDefaultUI(){
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 8.0)
    }
    
    func setDefaultLayout() {
        self.addSubviews([writerInfoStackView,separatorView,albumImage,songInfoStackView,tagStackView,contentsLabel,createdAtLabel])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }
        
        albumImage.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.height.width.equalTo(70)
        }
        
        songInfoStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.right).offset(10)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        tagStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.right).offset(10)
            $0.top.equalTo(songInfoStackView.snp.bottom).offset(7)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(albumImage.snp.bottom).offset(10)
        }
        
        createdAtLabel.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
    }
}
