//
//  MumentWithHeart.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

class DefaultMumentCardView: MumentCardWithoutHeartView {
    
    // MARK: - Properties
    private let heartButton = UIButton().then{
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 5
        configuration.buttonSize = .small
        $0.configuration = configuration
    }
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.mumentC1R12,
        .foregroundColor: UIColor.mGray1
    ]
    
    var heartCount: Int = 0 {
        didSet{
            heartButton.setAttributedTitle(NSAttributedString(string: "\(heartCount)",attributes: attributes), for: .normal)
        }
    }
    
    var isLiked: Bool = false{
        didSet{
            heartButton.setImage(isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart"), for: .normal)
        }
    }
    
    var mumentId: String = ""
    var userId: String = ""
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setButtonActions()
        self.backgroundColor = .mBgwhite
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Functions
    func setData(_ cellData: DefaultMumentCardModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        albumImage.image = cellData.albumImage
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTags
        feelingTags = cellData.feelingTags
        songTitleLabel.text = cellData.songTitle
        artistLabel.text = cellData.artistName
        contentsLabel.text = cellData.contentsLabel
        createdAtLabel.text = cellData.createdAtLabel
        heartButton.setImage(cellData.heartImage, for: .normal)
        isLiked = cellData.isLiked
        heartCount = cellData.heartCount
        setTags()
    }
    
    func setButtonActions(){
        heartButton.press {
            let previousState = self.isLiked
            self.isLiked.toggle()
            if previousState {
                self.heartCount -= 1
                self.requestDeleteHeartLiked(mumentId: self.mumentId)
            }else{
                self.heartCount += 1
                self.requestPostHeartLiked(mumentId: self.mumentId)
            }
        }
    }
    func setData(_ cellData: GetMyMumentResponseModel.Mument){
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
        albumImage.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTag
        feelingTags = cellData.feelingTag
        songTitleLabel.text = cellData.music.name
        artistLabel.text = cellData.music.artist
        contentsLabel.text = cellData.content
        createdAtLabel.text = cellData.createdAt
        isLiked = cellData.isLiked
        mumentId = cellData.id
//        if cellData.isLiked {
//            heartButton.setImage(UIImage(named: "heart_filled"), for: .normal)
//        }else{
//            heartButton.setImage(UIImage(named: "heart"), for: .normal)
//        }
        heartCount = cellData.likeCount
//        setTags()
        setCardTags(cellData.cardTag)
    }
}

// MARK: - UI
extension DefaultMumentCardView {
    func setLayout() {
        self.addSubview(heartButton)
        
        heartButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(5)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
    }
}

extension DefaultMumentCardView {
    private func requestPostHeartLiked(mumentId: String) {
        LikeAPI.shared.postHeartLiked(mumentId: mumentId, userId: UserInfo.shared.userId ?? "") { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? LikeResponseModel {
                }
                
            default:
                print("LikeAPI.shared.postHeartLiked")
                return
            }
        }
    }
    
    private func requestDeleteHeartLiked(mumentId: String) {
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId, userId: UserInfo.shared.userId ?? "") { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? LikeResponseModel {
                }
                
            default:
                print("LikeAPI.shared.deleteHeartLiked")
                return
            }
        }
    }
}


