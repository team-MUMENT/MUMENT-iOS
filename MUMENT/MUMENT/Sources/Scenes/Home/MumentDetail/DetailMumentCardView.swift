//
//  DetailMumentView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

protocol DetailMumentCardViewDelegate: AnyObject {
    func shareButtonClicked()
    func pushToLikedUserListVC()
}

final class DetailMumentCardView: UIView {
    
    // MARK: - Components
    private lazy var writerInfoStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let profileImage: UIImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 12.5)
        $0.contentMode = .scaleAspectFill
    }
    private let writerNameLabel: UILabel = UILabel().then {
        $0.textColor = .mBlack2
        $0.font = .mumentB6M13
    }
    let menuIconButton: UIButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "kebab")
    }
    private let separatorView: UIView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    let songInfoView: DetailSongInfoView = DetailSongInfoView()
    private let tagStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let tagSubStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
    }
    private let contentsLabel: UILabel = UILabel().then {
        $0.textColor = .mGray1
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 100
        $0.font = .mumentB4M14
    }
    private let createdAtLabel: UILabel = UILabel().then {
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    private lazy var heartStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    private let heartButton: MumentHeartButton = MumentHeartButton()
    private let likedUserButton: UIButton = UIButton()
    
    // MARK: - Properties
    private var delegate: DetailMumentCardViewDelegate?
    private var isFirst: Bool = false
    private var impressionTags: [Int] = []
    private var feelingTags: [Int] = []
    private var tagWidthSum: CGFloat = 0
    private var heartCount: Int = 0 {
        didSet {
            likedUserButton.setTitleWithCustom("\(heartCount)명이 좋아합니다.", font: .mumentC1R12, color: .mGray1, for: .normal)
        }
    }
    private let shareButton: UIButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "instagram")
    }
    private var isLiked: Bool = false
    private let privateLabel = UILabel().then {
        $0.font = .mumentC1R12
        $0.text = "비밀글"
        $0.textColor = .mGray1
    }
    private var mumentId: Int = 0
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setButtonActions()
    }
     
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentDetailResponseModel, _ musicData: MusicDTO, _ mumentId: Int) {
        profileImage.setImageUrl(cellData.user.image ?? APIConstants.defaultProfileImageURL)
        writerNameLabel.text = cellData.user.name
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTag
        feelingTags = cellData.feelingTag
        contentsLabel.text = cellData.content?.replaceNewLineKeyword()
        createdAtLabel.text = cellData.createdAt
        isLiked = cellData.isLiked
        self.heartButton.setImage(cellData.isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart"), for: .normal)
        heartCount = cellData.likeCount
        self.mumentId = mumentId
        hideMenuButton(userId: cellData.user.id)
        songInfoView.setData(musicData)
        setHeartStackViewLayout(isPrivate: cellData.isPrivate)
        setTags()
        updateContentLayout(content: cellData.content)
    }
    
    private func hideMenuButton(userId: Int) {
        if OfficialIdInfo.shared.idList.contains(userId) {
            self.menuIconButton.isHidden = true
        }
    }
    
    private func setHeartStackViewLayout(isPrivate: Bool) {
        heartStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        if isPrivate {
            heartStackView.addArrangedSubview(privateLabel)
            heartStackView.snp.updateConstraints {
                $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            }
        }else {
            heartStackView.addArrangedSubviews([heartButton, likedUserButton])
            heartStackView.snp.updateConstraints {
                $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            }
            heartButton.snp.makeConstraints {
                $0.height.width.equalTo(21.adjustedH)
            }
        }
    }
    
    private func setTags() {
        tagStackView.removeAllArrangedSubviews()
        tagSubStackView.removeAllArrangedSubviews()
        
        let tag = TagView()
        tag.tagType = "isFirst"
        tag.tagContentString = isFirst ? "처음" : "다시"
        tagStackView.addArrangedSubview(tag)
        
        if impressionTags.count != 0 {
            for i in 0...impressionTags.count-1 {
                let tag = TagView()
                tag.tagContent = impressionTags[i]
                
                if  tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                }else{
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
        
        if feelingTags.count != 0 {
            for i in 0...feelingTags.count-1 {
                let tag = TagView()
                tag.tagContent = feelingTags[i]
                
                if tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                } else {
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
    }
    
    private func setButtonActions() {
        heartButton.press {
            let previousState = self.isLiked
            if previousState {
                self.heartCount -= 1
                self.requestDeleteHeartLiked(mumentId: self.mumentId)
            } else {
                self.heartCount += 1
                self.requestPostHeartLiked(mumentId: self.mumentId)
            }
            self.heartButton.setIsSelected(!previousState)
            self.isLiked.toggle()
        }
        
        likedUserButton.press {
            if self.heartCount > 0 {
                self.delegate?.pushToLikedUserListVC()
            }
        }
        
        shareButton.press {
            self.delegate?.shareButtonClicked()
            sendGAEvent(eventName: .share_instagram, parameterValue: .click_instagram)
        }
    }
    
    func setDelegate(delegate: DetailMumentCardViewDelegate){
        self.delegate = delegate
    }
    
    private func updateContentLayout(content: String?) {
        if content == "" || content == nil {
            self.contentsLabel.snp.updateConstraints {
                $0.top.equalTo(tagSubStackView.snp.bottom).offset(0)
            }
            
            self.createdAtLabel.snp.updateConstraints {
                $0.top.equalTo(contentsLabel.snp.bottom).offset(22)
            }
        }
    }
}

// MARK: - UI
extension DetailMumentCardView {
    
    private func setUI() {
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: 0), opacity: 0.2, radius: 5.0)
    }
    
    private func setLayout() {
        self.addSubviews([writerInfoStackView, menuIconButton, separatorView, songInfoView, tagStackView, tagSubStackView, contentsLabel, createdAtLabel, shareButton, heartStackView])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        menuIconButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(38)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
        }
        separatorView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }
        songInfoView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(7)
            $0.top.equalTo(separatorView.snp.bottom).offset(7)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(72)
            $0.width.equalTo(144)
        }
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        tagSubStackView.snp.makeConstraints {
            $0.top.equalTo(tagStackView.snp.bottom).offset(8)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(tagSubStackView.snp.bottom).offset(14)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        heartStackView.snp.makeConstraints {
            $0.top.equalTo(createdAtLabel.snp.bottom).offset(10)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        shareButton.snp.makeConstraints {
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(2)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        profileImage.snp.makeConstraints {
            $0.height.width.equalTo(25)
        }
      
    }
}

extension DetailMumentCardView {
    private func requestPostHeartLiked(mumentId: Int) {
        LikeAPI.shared.postHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success: break
            default:
                print("LikeAPI.shared.postHeartLiked")
                return
            }
        }
    }
    
    private func requestDeleteHeartLiked(mumentId: Int) {
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success: break
            default:
                print("LikeAPI.shared.deleteHeartLiked")
                return
            }
        }
    }
}
