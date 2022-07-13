//
//  MumentWithHeart.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

class MumentWithHeartView: DefaultMumentView {
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.mumentC1R12,
        .foregroundColor: UIColor.mGray1
    ]
    
    var heartButtonText: String = "" {
        didSet{
            heartButton.setAttributedTitle(NSAttributedString(string: heartButtonText,attributes: attributes), for: .normal)
        }
    }
//    var attString = AttributedString(){
//    attString.font = .mumentC1R12
//    attString.foregroundColor = .mGray1
//    }
    // MARK: - Properties
    private let heartButton = UIButton().then{
//        $0.setTitleColor(.mGray1, for: .normal)
//        $0.titleLabel?.font = .mumentC1R12
        
        
//        attString.settingAttributes(NSAttributedString)
            
            // 2)
        var configuration = UIButton.Configuration.plain()
//            configuration.attributedTitle = attString
//            configuration.image = UIImage(named: "btn_arrowdown_black_10pt")
            configuration.imagePadding = 5
//            configuration.imagePlacement = .trailing
        $0.configuration = configuration
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentWithHeartModel){
        profileImage.image = cellData.profileImage
        writerNameLabel.text = cellData.writerName
        albumImage.image = cellData.albumImage
        songTitleLabel.text = cellData.songTitle
        artistLabel.text = cellData.artistName
        contentsLabel.text = cellData.contentsLabel
        createdAtLabel.text = cellData.createdAtLabel
//        heartButton.setImage(cellData.heartImage, for: .normal)
//        heartButton.setTitle(" \(cellData.heartCount)", for: .normal)
        heartButton.setImage(cellData.heartImage, for: .normal)
//        heartButton.setAttributedTitle(NSAttributedString(string: "\(cellData.heartCount)",attributes: attributes), for: .normal)
        heartButtonText = "\(cellData.heartCount)"
//        heartButton.configuration?.title = "\(cellData.heartCount)"
//        setAttributedTitle(" \(cellData.heartCount)", for: .normal)
//        setTitle(" \(cellData.heartCount)", for: .normal)
    }
}

// MARK: - UI
extension MumentWithHeartView {
    func setLayout() {
        self.addSubview(heartButton)

        heartButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }

    }
}

