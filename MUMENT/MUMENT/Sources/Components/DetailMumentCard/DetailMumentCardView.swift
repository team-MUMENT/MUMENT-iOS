//
//  DetailMumentView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class DetailMumentCardView: UIView {
    
    // MARK: - Properties
    lazy var writerInfoStackView = UIStackView(arrangedSubviews: [profileImage, writerNameLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let profileImage = UIImageView().then{
        $0.makeRounded(cornerRadius: 12.5)
    }
    private let writerNameLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentB6M13
    }
    
    private let menuIconButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "kebab")
    }
    
    private let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
    }
    
    let songInfoView = DetailSongInfoView()
    
    private let tagStackView = UIStackView()
    private let contentsLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 100
        $0.font = .mumentB4M14
    }
    private let createdAtLabel = UILabel().then{
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    
    lazy var heartStackView = UIStackView(arrangedSubviews: [heartButton, heartLabel]).then{
        $0.axis = .horizontal
    }
    private let heartButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.buttonSize = .small
    }
    private let heartLabel = UILabel().then{
        $0.font = .mumentC1R12
        $0.textColor = .mGray1
    }
    
    private let shareButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "share")
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
//        setButtonActions()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
//        tapGestureRecognizer.delegate = self
        songInfoView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        setUI()
//        setLayout()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
//        tapGestureRecognizer.delegate = self
//        songInfoView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentDetailVCModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        songInfoView.setData(cellData)
        contentsLabel.text = cellData.contents
        createdAtLabel.text = cellData.createdAt
        heartButton.setImage(cellData.heartImage, for: .normal)
        heartLabel.text = "\(cellData.heartCount)명이 좋아합니다."
    }
//
//    func setButtonActions(){
//        shareButton.press{
//            print("shareButton")
//        }
//    }
}

//extension DetailMumentCardView: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return true
//    }
//}

// MARK: - UI
extension DetailMumentCardView {
    
    func setUI(){
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 2.0)
    }
    
    func setLayout() {
        self.addSubviews([writerInfoStackView,menuIconButton,separatorView,songInfoView,tagStackView,contentsLabel,createdAtLabel,heartStackView,shareButton])
        
        writerInfoStackView.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        menuIconButton.snp.makeConstraints{
            $0.right.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(38)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
        }
        
        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(11)
            $0.height.equalTo(1)
        }
        
        songInfoView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(7)
            $0.top.equalTo(separatorView.snp.bottom).offset(7)
            $0.height.equalTo(72)
            $0.width.equalTo(144)
        }
        
        tagStackView.snp.makeConstraints{
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        contentsLabel.snp.makeConstraints{
            $0.top.equalTo(tagStackView.snp.bottom).offset(22)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        createdAtLabel.snp.makeConstraints{
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
        }
        heartStackView.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(5)
            
        }
        
        shareButton.snp.makeConstraints{
            $0.top.equalTo(createdAtLabel.snp.bottom)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(25)
        }
        
        heartButton.snp.makeConstraints{
            $0.height.width.equalTo(38)
        }
    }
}

