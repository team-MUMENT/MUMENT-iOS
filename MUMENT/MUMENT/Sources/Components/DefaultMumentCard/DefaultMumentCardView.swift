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
//        heartButtonText = "\(cellData.heartCount)"
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
        LikeAPI.shared.postHeartLiked(mumentId: mumentId, userId: "62cd5d4383956edb45d7d0ef") { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? LikeResponseModel {
                    print("!~~~~~~~~",res)
                }

            default:
                print("LikeAPI.shared.postHeartLiked")
                return
            }
        }
    }
    
    private func requestDeleteHeartLiked(mumentId: String) {
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId, userId: "62cd5d4383956edb45d7d0ef") { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? LikeResponseModel {
                    print("!~~~~~~~~",res)
                }
                
            default:
                print("LikeAPI.shared.deleteHeartLiked")
                return
            }
        }
    }
}


