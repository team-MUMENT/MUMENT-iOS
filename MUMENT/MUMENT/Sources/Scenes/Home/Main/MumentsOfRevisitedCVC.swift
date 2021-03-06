//
//  MumentsOfRevisitedCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

protocol MumentsOfRevisitedCVCDelegate : AnyObject{
    func mumentsOfRevisitedCVCSelected(data: MumentsOfRevisitedResponseModel.AgainMument)
}

class MumentsOfRevisitedCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    lazy var contentsStackView = UIStackView(arrangedSubviews: [mumentInfoStackView, writerInfoStackView]).then{
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    lazy var mumentInfoStackView = UIStackView(arrangedSubviews: [titleLabel, contentsLabel]).then{
        $0.axis = .vertical
        $0.spacing = 5
    }
    private let titleLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentB5B13
    }
    private let contentsLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
    }
    
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 6
    }
    private var profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 9.5)
    }
    private let writerNameLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentC1R12
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentsOfRevisitedModel){
        albumImage.image = cellData.albumImage
        titleLabel.text = cellData.title
        contentsLabel.text = cellData.contents
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
    }
    
    func setData(_ cellData: MumentsOfRevisitedResponseModel.AgainMument){
        albumImage.setImageUrl(cellData.music.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        titleLabel.text = "\(cellData.music.name) - \(cellData.music.artist)"
        contentsLabel.text = cellData.content
        profileImage.setImageUrl(cellData.user.image ?? "https://mument.s3.ap-northeast-2.amazonaws.com/user/emptyImage.jpg")
        writerNameLabel.text = cellData.user.name
    }
}

// MARK: - UI
extension MumentsOfRevisitedCVC {
    
    private func setUI(){
        self.makeRounded(cornerRadius: 12)
        self.backgroundColor = .mGray4
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 4.0)
    }
    
    private func setLayout() {
        
        self.addSubviews([albumImage,contentsStackView])
        
        albumImage.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(160)
        }
        
        contentsStackView.snp.makeConstraints{
            $0.top.equalTo(albumImage.snp.bottom).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(13)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(13)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(11)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(19)
        }
    }
}

