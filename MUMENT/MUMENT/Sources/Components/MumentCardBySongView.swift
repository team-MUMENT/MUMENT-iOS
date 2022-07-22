//
//  MumentCardBySongView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MumentCardBySongView: UIView {
    
    // MARK: - Properties
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 7
    }
    let profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12.5)
    }
    let writerNameLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentC1R12
        $0.sizeToFit()
    }
    
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
    
    let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    
    var isFirst: Bool = false
    var impressionTags: [Int] = []
    var feelingTags: [Int] = []
    var cardTags: [Int] = []
    let tagStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    let contentsLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 3
        $0.font = .mumentB6M13
    }
    let createdAtLabel = UILabel().then{
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
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
        setUI()
        setLayout()
        setButtonActions()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Functions
    func setData(_ cellData: HistoryResponseModel.MumentHistory){
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
        contentsLabel.text = cellData.content
        createdAtLabel.text = cellData.date
        isLiked = cellData.isLiked
        heartCount = cellData.likeCount
        isFirst = cellData.isFirst
        cardTags = cellData.cardTag
        mumentId = cellData.id
        setTags()
    }
    
    func setData(_ cellData: AllMumentsResponseModel.MumentList){
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
        contentsLabel.text = cellData.content
        createdAtLabel.text = cellData.date
        isLiked = cellData.isLiked
        heartCount = cellData.likeCount
        isFirst = cellData.isFirst
        cardTags = cellData.cardTag
        mumentId = cellData.id
        setTags()
    }
    
    func setData(_ cellData: SongInfoResponseModel.MyMument){
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
        contentsLabel.text = cellData.content
        createdAtLabel.text = cellData.date
        isLiked = cellData.isLiked
        heartCount = cellData.likeCount
        isFirst = cellData.isFirst
        cardTags = cellData.cardTag
        mumentId = cellData.id
        setTags()
    }
    
    func setTags(){
        tagStackView.removeAllArrangedSubviews()
        
        let tag = TagView()
        tag.tagType = "isFirst"
        tag.tagContentString = isFirst ? "처음" : "다시"
        tagStackView.addArrangedSubview(tag)
        
        if cardTags.count != 0{
            for i in 0...cardTags.count-1{
                let tag = TagView()
                tag.tagContent = cardTags[i]
                tagStackView.addArrangedSubview(tag)
            }
        }
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
extension MumentCardBySongView {
    
    func setUI(){
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.1,radius: 3.0)
    }
    
    func setLayout() {
        self.addSubviews([writerInfoStackView,heartButton,separatorView,tagStackView,contentsLabel,createdAtLabel])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        heartButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(5)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }
        
        tagStackView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(separatorView.snp.bottom).offset(11)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(tagStackView.snp.bottom).offset(8)
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

extension MumentCardBySongView {
    private func requestPostHeartLiked(mumentId: String) {
        LikeAPI.shared.postHeartLiked(mumentId: mumentId, userId: "62cd5d4383956edb45d7d0ef") { networkResult in
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
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId, userId: "62cd5d4383956edb45d7d0ef") { networkResult in
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

