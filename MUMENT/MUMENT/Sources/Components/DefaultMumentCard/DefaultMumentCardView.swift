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
    private let heartButton: MumentHeartButton = MumentHeartButton()
    
    private let privateLabel = UILabel().then {
        $0.font = .mumentC1R12
        $0.text = "비밀글"
        $0.textColor = .mGray1
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
    
    var isLiked: Bool = false
    
    var mumentId: Int = 0
    var userId: String = ""

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setButtonActions()
        self.backgroundColor = .mBgwhite
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Functions
    func setButtonActions(){
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
    }
    
    func setDefaultData(_ cellData: StorageMumentModel){
        profileImage.setImageUrl(cellData.user.image ?? APIConstants.defaultProfileImageURL)
        writerNameLabel.text = cellData.user.name
        albumImage.setImageUrl(cellData.music.image)
        isFirst = cellData.isFirst
        songTitleLabel.text = cellData.music.name
        artistLabel.text = cellData.music.artist
        contentsLabel.text = cellData.content?.replaceNewLineKeyword()
        createdAtLabel.text = cellData.createdAt
        mumentId = cellData.id
        setCardTags(cellData.cardTag)
        
        /// isPrivate = true 일때 HeartButton hidden
        if cellData.isPrivate {
            heartButton.isHidden = true
            privateLabel.isHidden = false
        } else {
            privateLabel.isHidden = true
            heartButton.isHidden = false
            isLiked = cellData.isLiked
            self.heartButton.setImage(cellData.isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart"), for: .normal)
            heartCount = cellData.likeCount
        }
        
        if contentsLabel.text == nil {
            contentsLabel.isHidden = true
        } else {
            contentsLabel.isHidden = false
        }
    }
}

// MARK: - UI
extension DefaultMumentCardView {
    func setLayout() {
        self.addSubviews([heartButton, privateLabel])
        heartButton.snp.updateConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(5)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
        privateLabel.snp.updateConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(15)
        }
    }
}

extension DefaultMumentCardView {
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
