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
        $0.contentMode = .scaleAspectFill
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
    func setData(_ cellData: MumentsOfRevisitedResponseModel.AgainMument){
        albumImage.setImageUrl(cellData.music.image)
        titleLabel.text = "\(cellData.music.name) - \(cellData.music.artist)"
        contentsLabel.text = cellData.content
        profileImage.setImageUrl(cellData.user.image ?? APIConstants.defaultProfileImageURL)
        writerNameLabel.text = cellData.user.name
        
        contentsLabel.sizeToFit()
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
        
        self.addSubviews([albumImage, titleLabel, contentsLabel, writerInfoStackView])
        
        albumImage.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(160)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.albumImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            make.height.equalTo(18)
        }
        
        self.contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.profileImage.snp.makeConstraints{
            $0.height.width.equalTo(19)
        }
        
        self.writerInfoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(11)
        }
    }
}

