//
//  InstagramShareImageRenderer.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/26.
//

import UIKit
import SnapKit
import Then

final class InstagramShareView: UIView {
    
    // MARK: - Properties
    private var isFirst: Bool = false
    private var impressionTags: [Int] = []
    private var feelingTags: [Int] = []
    
    // MARK: - Components
    private let mumentCardView: UIView = UIView().then {
        $0.backgroundColor = .mBgwhite
        $0.makeRounded(cornerRadius: 11)
    }
    private let writerProfileImageView: UIImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 12.5)
        $0.contentMode = .scaleAspectFill
    }
    private let writerNameLabel: UILabel = UILabel().then {
        $0.textColor = .mBlack2
        $0.font = .mumentC1R12
    }
    private lazy var writerInfoStackView = UIStackView(arrangedSubviews: [writerProfileImageView, writerNameLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    private let albumImageView: UIImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 5)
    }
    private let musicTitleLabel: UILabel = UILabel().then {
        $0.textColor = .mBlack2
        $0.font = .mumentB2B14
        $0.textAlignment = .center
    }
    private let artistNameLabel: UILabel = UILabel().then {
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
        $0.textAlignment = .center
    }
    private let tagStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let tagSubStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let contentsLabel: UILabel = UILabel().then {
        $0.textColor = .mGray1
        $0.lineBreakMode = .byTruncatingTail
        $0.lineBreakStrategy = .pushOut
        $0.numberOfLines = 6
        $0.font = .mumentB4M14
    }
    private let createdAtLabel: UILabel = UILabel().then {
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    private let mumentLogoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "mumentLogo")
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        self.backgroundColor = .clear
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Functions
    func setData(_ cellData: MumentDetailResponseModel, _ musicData: MusicDTO) {
        writerProfileImageView.setImageUrl(cellData.user.image ?? APIConstants.defaultProfileImageURL)
        writerNameLabel.text = cellData.user.name
        isFirst = cellData.isFirst
        impressionTags = cellData.impressionTag
        feelingTags = cellData.feelingTag
        contentsLabel.text = "대학교 2학년 때, 동아리 사람들과 엠티를 갔었는데 다들 신나서 이 곡을 떼창한 기억이 있다. 그 이후로 여름이 될 때마다 이 노래를 찾아 듣고 그 때 생각을 하는데, 그때 우리가 가지고 있던 별거 아닌 고민들은 다 옛날일이 되어버렸지만, 같이 노래를 부르면서 위로했던대학교 2학년 때, 동아리 사람들과 엠티를 갔었는데 다들 신나서 이 곡을 떼창한 기억이 있다. 그 이후로 여름이 될 때마다 이 노래를 찾아 듣고 그 때 생각을 하는데, 그때 우리가 가지고 있던 별거 아닌 고민들은 다 옛날일이 되어버렸지만, 같이 노래를 부르면서 위로했던"
        createdAtLabel.text = cellData.createdAt
        albumImageView.setImageUrl(musicData.albumUrl)
        musicTitleLabel.text = "대학교 2학년 때, 동아리 사람들과 엠티를 갔었는데 다들 신나서 이 곡을 떼창한 기억이 있다. 그 이후로 여름이 될 때마다 이 노래를 찾아 듣고 그 때 생각을 하는데, 그때 우리가 가지고 있던 별거 아닌 고민들은 다 옛날일이 되어버렸지만, 같이 노래를 부르면서 위로했던"
        artistNameLabel.text = "대학교 2학년 때, 동아리 사람들과 엠티를 갔었는데 다들 신나서 이 곡을 떼창한 기억이 있다. 그 이후로 여름이 될 때마다 이 노래를 찾아 듣고 그 때 생각을 하는데, 그때 우리가 가지고 있던 별거 아닌 고민들은 다 옛날일이 되어버렸지만, 같이 노래를 부르면서 위로했던"
        
        setTags()
    }
    
    private func setTags(){
        
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
                
                if  tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                } else {
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
    }
}

// MARK: - UI
extension InstagramShareView {
    
    private func setLayout() {
        self.addSubviews([mumentCardView])
        mumentCardView.addSubviews([writerInfoStackView, separatorView, albumImageView, musicTitleLabel, artistNameLabel, tagStackView, tagSubStackView, contentsLabel, createdAtLabel, mumentLogoImageView])
        
        mumentCardView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(87)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(42)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(42)
        }
        writerInfoStackView.snp.makeConstraints {
            $0.top.equalTo(mumentCardView.snp.top).offset(12)
            $0.left.equalToSuperview().offset(13)
        }
        separatorView.snp.makeConstraints {
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().inset(13)
            $0.height.equalTo(1)
        }
        albumImageView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(159)
        }
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(artistNameLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        tagSubStackView.snp.makeConstraints {
            $0.top.equalTo(tagStackView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(tagSubStackView.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().inset(13)
        }
        createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().inset(17)
        }
        mumentLogoImageView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.right.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(17)
            $0.width.equalTo(81)
            $0.height.equalTo(19)
        }
        
        writerProfileImageView.snp.makeConstraints {
            $0.width.height.equalTo(25)
        }
    }
}
