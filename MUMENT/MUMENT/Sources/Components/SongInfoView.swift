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
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
//        DispatchQueue.main.async {
//            <#code#>
//        }
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
//        let tapGestureRecognizer = UITapGestureRecognizer()
//        self.addGestureRecognizer(tapGestureRecognizer)
//        tapGestureRecognizer.delegate = self
//        self.isUserInteractionEnabled = true
    }
    
//    @objc func didTapView(_ sender: UITapGestureRecognizer) {
//        print("did tap view", sender)
//    }

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

//extension SongInfoView: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//
//        return true
//    }
//}

// MARK: - UI
extension SongInfoView {
    
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
        }
        
        writeMumentButton.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.top.equalTo(albumImage.snp.bottom).offset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            
        }
    }
}
