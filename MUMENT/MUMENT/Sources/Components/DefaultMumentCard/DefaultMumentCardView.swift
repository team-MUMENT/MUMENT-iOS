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
    
    var heartButtonText: String = "" {
        didSet{
            heartButton.setAttributedTitle(NSAttributedString(string: heartButtonText,attributes: attributes), for: .normal)
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setTags()
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
        heartButtonText = "\(cellData.heartCount)"
    }
    
//    func setTags(){
//        let tag = TagView()
//        tag.tagType = "isFirst"
//        tag.tagContentString = isFirst ? "처음" : "다시"
//        tagStackView.addArrangedSubview(tag)
//        
//        
//        if impressionTags.count != 0{
//            for i in 0...impressionTags.count{
//                let tag = TagView()
//                tag.tagContent = impressionTags[i]
//                tagStackView.addArrangedSubview(tag)
//            }
//        }
//        
//        if feelingTags.count != 0{
//            for i in 0...feelingTags.count{
//                let tag = TagView()
//                tag.tagContent = feelingTags[i]
//                tagStackView.addArrangedSubview(tag)
//            }
//        }
//    }
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

