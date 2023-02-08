//
//  MumentsByTagCardView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/09/10.
//

import UIKit
import SnapKit
import Then

class MumentsByTagCardView: UIView {
    
    lazy var titleSectionStackView = UIStackView(arrangedSubviews: [titleIconImage, titleAndArtistLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
    }
    
    private let titleIconImage = UIImageView().then{
        $0.image = UIImage(named: "mumentMusicnote")
    }
    
    private let titleAndArtistLabel = UILabel().then{
        $0.textColor = .mBlack2
        $0.font = .mumentB5B13
    }
    
    private let contentsLabel = UILabel().then{
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 5
    }
    
    let separatorView = UIView().then{
        $0.backgroundColor = .mGray4
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
        super.init(frame: .zero)
        setDefaultUI()
        setDefaultLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setData(_ cellData: MumentsByTagResponseModel.MumentList){
        titleAndArtistLabel.text = "\(cellData.music.name) - \(cellData.music.artist)"
        contentsLabel.text = cellData.content ?? ""
        profileImage.setImageUrl(cellData.user.image ?? "")
        writerNameLabel.text = cellData.user.name
    }
}

extension MumentsByTagCardView {
    private func setDefaultUI(){
        self.makeRounded(cornerRadius: 11)
        self.backgroundColor = .mWhite
        self.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 4.0)
    }
    
    private func setDefaultLayout() {
        
        self.addSubviews([writerInfoStackView,separatorView, titleSectionStackView,contentsLabel])
        
        writerInfoStackView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        separatorView.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(1)
        }
        
        titleSectionStackView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.top.equalTo(titleSectionStackView.snp.bottom).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(13)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(13)
        }
        
        titleIconImage.snp.makeConstraints{
            $0.height.width.equalTo(12)
        }
        
        profileImage.snp.makeConstraints{
            $0.height.width.equalTo(24)
        }
        
    }
}
