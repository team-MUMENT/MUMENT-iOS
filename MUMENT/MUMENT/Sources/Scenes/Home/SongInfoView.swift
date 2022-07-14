//
//  SongInfoView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//
import UIKit
import SnapKit
import Then

class SongInfoView: UIView {
    
    // MARK: - Properties
    lazy var contentsStackView = UIStackView(arrangedSubviews: [songStackView, writeMumentButton]).then{
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    lazy var songStackView = UIStackView(arrangedSubviews: [albumImage, songInfoStackView]).then{
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 15
    }
    private let albumImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 7)
        $0.clipsToBounds = true
    }
    lazy var songInfoStackView = UIStackView(arrangedSubviews: [titleLabel, artistLabel]).then{
        $0.axis = .vertical
        $0.spacing = 10
        
    }
    private let titleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }
    private let artistLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB4M14
    }
//    private let heartButton = UIButton().then{
//        var configuration = UIButton.Configuration.plain()
//            configuration.imagePadding = 5
//            configuration.buttonSize = .small
//        $0.configuration = configuration
//    }
    
    
    private let writeMumentButton = UIButton().then{
        $0.makeRounded(cornerRadius: 11)
        $0.backgroundColor = .mPurple1
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "logo")
        $0.configuration?.imagePadding = 5
//        $0.setTitle("", for: .normal)
        $0.layer.cornerRadius = 10
        $0.setAttributedTitle(NSAttributedString(string: "뮤멘트 기록하기",attributes: [
            .font: UIFont.mumentB7B12,
            .foregroundColor: UIColor.mWhite
        ]), for: .normal)
        //        $0.contentHorizontalAlignment = .left
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
    func setData(_ cellData: SongDetailInfoModel){
        albumImage.image = cellData.albumImage
        titleLabel.text = cellData.songtitle
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension SongInfoView {
    
    private func setLayout() {
        self.addSubviews([contentsStackView])
        
        contentsStackView.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        albumImage.snp.makeConstraints{
            $0.height.width.equalTo(114)
        }
        
        writeMumentButton.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        
//        songInfoStackView.snp.makeConstraints{
//            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(68)
//        }
        songInfoStackView.snp.makeConstraints{
            $0.height.equalTo(46)
            
        }
    }
}
