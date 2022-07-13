//
//  MumentsOfRevisitedCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

class MumentsOfRevisitedCVC: UICollectionViewCell {

    // MARK: - Properties
    
    private let albumImage = UIImageView().then{
        $0.roundCorners([UIRectCorner.topLeft,UIRectCorner.topRight], radius: 12)
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
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    private let contentsLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
            $0.axis = .horizontal
            $0.spacing = 6
        }
    private let profileImage = UIImageView()
    private let writerNameLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
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
}

// MARK: - UI
extension MumentsOfRevisitedCVC {
    
    private func setLayout() {
        self.addSubviews([albumImage,contentsStackView])
        
        albumImage.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(160)
        }
        
        contentsStackView.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(13)
                        $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(13)
                        $0.top.equalTo(albumImage.snp.bottom).offset(10)
            $0.bottom.equalTo(albumImage.snp.bottom).offset(11)
        }
        
//
//        titleLabel.snp.makeConstraints{
//            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(13)
//            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(13)
//            $0.top.equalTo(albumImage.snp.bottom).offset(10)
//        }
//
//        contentsLabel.snp.makeConstraints{
//            $0.top.equalTo(headerLable.snp.bottom).offset(50)
//            $0.leading.equalTo(albumImage.snp.trailing).offset(20)
//        }
//
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(19)
        }
//
//        writerName.snp.makeConstraints {
//            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(38)
//            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(26)
//        }
    }
}

