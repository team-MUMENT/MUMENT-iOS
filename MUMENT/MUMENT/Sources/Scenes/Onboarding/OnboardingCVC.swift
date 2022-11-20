//
//  OnboardingCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

class OnboardingCVC: UICollectionViewCell {
    
    private let headingLabel: UILabel = UILabel().then{
        $0.font = .mumentH1B25
                $0.textColor = .mGray2
//                $0.text = "로그인 시 이용약관과\n개인정보처리방침에 동의하게 됩니다."
//                $0.textAlignment = .center
//                $0.sizeToFit()
//                $0.setHyperlinkedStyle(to: ["이용약관","개인정보처리방침"],with:.mumentB7B12)
    }
    
    private let subHeadingLabel: UILabel = UILabel().then{
        $0.font = .mumentH4M16
        $0.textColor = .mGray1
        $0.numberOfLines = 2
        $0.textAlignment = .center
        
    }
    private var backgroundImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    
    private var backgroundImageTitle: String = "" {
        didSet{
            setBackgroundImage()
        }
    }
    
//    :String{
//        didSet{
//            let backgroundImageView = UIImageView(frame: super.view.frame)
//            backgroundImageView.image = UIImage(named: backgroundImageTitle)
//            self.view.addSubview(backgroundImageView)
//        }
//    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: OnboardingModel){
        headingLabel.text = cellData.heading
        subHeadingLabel.text = cellData.subHeading
//        backgroundImageView.image = cellData.backgroundImage
        backgroundImageTitle = cellData.backgroundImageTitle
        
    }
}

// MARK: - UI
extension OnboardingCVC {
    
    private func setBackgroundImage(){
            let backgroundImageView = UIImageView(frame: frame)
            backgroundImageView.image = UIImage(named: backgroundImageTitle)
            backgroundImageView.contentMode = .scaleAspectFit
//            self.view.addSubview(backgroundImageView)
        self.backgroundView = backgroundImageView
        }
//
    private func setUI() {
//        self.backgroundView = backgroundImageView
        self.addSubviews([headingLabel, subHeadingLabel])

        headingLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(115)
            $0.centerX.equalToSuperview()
        }
        
        subHeadingLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
    }
}

