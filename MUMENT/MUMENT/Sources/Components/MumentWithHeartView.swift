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
    
    // MARK: - Properties
    private let heartButton = UIButton().then{
        $0.setTitleColor(.mGray1, for: .normal)
        $0.titleLabel?.font = .mumentC1R12
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
        heartButton.setImage(cellData.heartImage, for: .normal)
        heartButton.setTitle(" \(cellData.heartCount)", for: .normal)
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

