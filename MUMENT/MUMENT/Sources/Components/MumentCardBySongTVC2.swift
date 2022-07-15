//
//  MumentCardBySongView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MumentCardBySongTVC: UITableViewCell {
    
    // MARK: - Properties
    private let mumentCard = MumentCardBySongView()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setUI()
        setLayout()
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setData(_ cellData: MumentCardBySongModel){
        mumentCard.setData(cellData)
//        profileImage.image = cellData.profileImage
//        writerNameLabel.text = cellData.writerName
//        contentsLabel.text = cellData.contents
//        createdAtLabel.text = cellData.createdAt
//        heartButton.setImage(cellData.heartImage, for: .normal)
//        heartButtonText = "\(cellData.heartCount)"
    }
}

// MARK: - UI
extension MumentCardBySongTVC {
    
    func setUI(){
        self.backgroundColor = .mWhite
        self.makeRounded(cornerRadius: 11)
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 8.0)
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))

    }
    
    func setLayout() {
        self.addSubviews([mumentCard])
        
        mumentCard.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
    }
}

