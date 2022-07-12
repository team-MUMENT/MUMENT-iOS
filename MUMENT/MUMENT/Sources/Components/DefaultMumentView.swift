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
    private let profileImage = UIImageView()
    private let writerNameLabel = UILabel()
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 7
    }
    private let separatorView = UIView()
    
    //    lazy var songInfroView = UIView().then{
    //        $0.addSubviews([albumImage,songTitle,artistLabel,tagStackView])
    //        albumImage.snp.makeConstraints{
    //            $0.height.width.equalTo(70)
    //            $0.left.top.bottom
    //        }
    //    }
    
    private let albumImage = UIImageView()
    
    lazy var songInfoStackView = UIStackView(arrangedSubviews: [songTitle, artistLabel]).then{
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    private let songTitle = UILabel()
    private let artistLabel = UILabel()
    
    //data에 있는 것 만큼 DefaultTagView()하고 stack view에 추가
    private let tagStackView = UIStackView()
    private let contentsLabel = UILabel()
    private let createdAtLabel = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        setLayout()
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
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
        }
        
        albumImage.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.height.width.equalTo(70)
        }
        
        songInfoStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.leading).offset(10)
        }
        
        tagStackView.snp.makeConstraints{
            $0.left.equalTo(albumImage.snp.leading).offset(10)
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
    }
}

