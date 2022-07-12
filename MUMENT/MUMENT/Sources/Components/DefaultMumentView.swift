//
//  DefaultMumentView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/12.
//
import UIKit
import SnapKit
import Then

class DefaultMumentView: UIView {
    
    // MARK: - Properties
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 7
    }
    
    private let profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12.5)
    }
    
    private let writerNameLabel = UILabel().then{
        $0.font = .mumentC1R12
    }
    
    private let separatorView = UIView().then{
        $0.tintColor = .mGray4
    }
    
    //    lazy var songInfroView = UIView().then{
    //        $0.addSubviews([albumImage,songTitle,artistLabel,tagStackView])
    //        albumImage.snp.makeConstraints{
    //            $0.height.width.equalTo(70)
    //            $0.left.top.bottom
    //        }
    //    }
    
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 4)
    }
    
    lazy var songInfoStackView = UIStackView(arrangedSubviews: [songTitleLabel, artistLabel]).then{
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    private let songTitleLabel = UILabel().then{
        $0.font = .mumentB3B14
    }
    private let artistLabel = UILabel().then{
        $0.font = .mumentB3M13
    }
    
    //data에 있는 것 만큼 DefaultTagView()하고 stack view에 추가
    private let tagStackView = UIStackView()
    private let contentsLabel = UILabel().then{
        $0.font = .mumentB6M13
    }
    private let createdAtLabel = UILabel().then{
        $0.font = .mumentC1R12
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
                setLayout()
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentForTodayModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        albumImage.image = cellData.albumImage
        songTitleLabel.text = cellData.songTitle
        artistLabel.text = cellData.artistName
        contentsLabel.text = cellData.contentsLabel
        createdAtLabel.text = cellData.createdAtLabel
    }
    

}

// MARK: - UI
extension DefaultMumentView {
    func setLayout() {
        self.addSubviews([writerInfoStackView,separatorView,albumImage,songInfoStackView,tagStackView,contentsLabel,createdAtLabel])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }
        
        albumImage.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.height.width.equalTo(70)
        }
        
        songInfoStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.left).offset(10)
        }
        
        tagStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.left).offset(10)
            $0.top.equalTo(songInfoStackView.snp.bottom).offset(7)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(albumImage.snp.bottom).offset(10)
        }
        
        createdAtLabel.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(12)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
    }
}

