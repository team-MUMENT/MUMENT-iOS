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
    
    private let writeMumentButton = UIButton()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
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
    }
}
