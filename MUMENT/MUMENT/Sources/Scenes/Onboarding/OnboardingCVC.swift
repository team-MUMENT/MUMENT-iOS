//
//  OnboardingCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

final class OnboardingCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private var highlightedHeadingText: String = "" {
        didSet{
            headingLabel.setColor(to: highlightedHeadingText, with: .mPurple1)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Components
    private let headingLabel: UILabel = UILabel().then{
        $0.font = .mumentH1B25
        $0.textColor = .mBlack1
    }
    
    private let subHeadingLabel: UILabel = UILabel().then{
        $0.font = .mumentH4M16
        $0.textColor = .mGray1
        $0.numberOfLines = 2
        $0.textAlignment = .center
        
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setBackgroundImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func setData(_ cellData: OnboardingModel){
        self.headingLabel.text = cellData.heading
        self.highlightedHeadingText = cellData.highlightedHeading
        self.subHeadingLabel.text = cellData.subHeading
        self.imageView.image = cellData.image
        

    }
}

// MARK: - UI
extension OnboardingCVC {
    
    private func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: frame)
        backgroundImageView.image = UIImage(named: "onboarding_background")
        backgroundImageView.contentMode = .scaleToFill
        self.backgroundView = backgroundImageView
    }
    
    private func setUI() {
        self.addSubviews([headingLabel, subHeadingLabel, imageView])
        
        self.headingLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(115.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        self.subHeadingLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel.snp.bottom).offset(17.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.subHeadingLabel.snp.bottom).offset(90.adjustedH)
            make.centerX.equalToSuperview()
            make.width.equalTo(350.adjustedH)
            make.height.equalTo( 350.adjustedH * 320.adjustedH / 350.adjustedH)
        }
    }
}
