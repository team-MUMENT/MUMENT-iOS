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
    
    private var backgroundImageTitle: String = "" {
        didSet{
            setBackgroundImage()
        }
    }
    
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
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: OnboardingModel){
        headingLabel.text = cellData.heading
        highlightedHeadingText = cellData.highlightedHeading
        subHeadingLabel.text = cellData.subHeading
        backgroundImageTitle = cellData.backgroundImageTitle
    }
}

// MARK: - UI
extension OnboardingCVC {
    
    private func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: frame)
        backgroundImageView.image = UIImage(named: backgroundImageTitle)
        backgroundImageView.contentMode = .scaleAspectFill
        self.backgroundView = backgroundImageView
    }
    
    private func setUI() {
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
