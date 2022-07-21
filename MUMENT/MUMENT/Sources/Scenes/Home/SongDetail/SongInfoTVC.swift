//
//  SongInfoTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/19.
//

import UIKit
import SnapKit
import Then

class SongInfoTVC: UITableViewCell {
    
    // MARK: - Properties
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
    
    let writeMumentButton = UIButton().then{
        $0.makeRounded(cornerRadius: 11)
        $0.backgroundColor = .mPurple1
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "logo")
        $0.configuration?.imagePadding = 5
        $0.layer.cornerRadius = 10
        $0.setAttributedTitle(NSAttributedString(string: "뮤멘트 기록하기",attributes: [
            .font: UIFont.mumentB7B12,
            .foregroundColor: UIColor.mWhite
        ]), for: .normal)
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setData(_ cellData: SongDetailInfoModel){
        albumImage.image = cellData.albumImage
        titleLabel.text = cellData.songtitle
        artistLabel.text = cellData.artist
    }
    
    func setData(_ cellData: SongInfoResponseModel.Music){
        albumImage.setImageUrl(cellData.image)
        titleLabel.text = cellData.name
        artistLabel.text = cellData.artist
    }
}

// MARK: - UI
extension SongInfoTVC {
    
    private func setLayout() {
        self.addSubviews([albumImage,songInfoStackView,writeMumentButton])
        
        albumImage.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(28)
            $0.height.width.equalTo(114)
            
        }
        
        songInfoStackView.snp.makeConstraints{
            $0.leading.equalTo(albumImage.snp.trailing).offset(15)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(28)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        writeMumentButton.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.top.equalTo(albumImage.snp.bottom).offset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            
        }
    }
}
