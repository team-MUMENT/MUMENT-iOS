//
//  MumentWithHeart.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

final class DefaultMumentCardView: MumentCardWithoutHeartView {
    
    // MARK: - Properties
    let heartButton: MumentHeartButton = MumentHeartButton()
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
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .mBgwhite
        setLayout()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - Functions
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
