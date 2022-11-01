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
    
    private let phraseLabel = UILabel().then{
        $0.font = .mumentB8M12
                $0.textColor = .mGray2
//                $0.text = "로그인 시 이용약관과\n개인정보처리방침에 동의하게 됩니다."
                $0.numberOfLines = 2
//                $0.textAlignment = .center
//                $0.sizeToFit()
//                $0.setHyperlinkedStyle(to: ["이용약관","개인정보처리방침"],with:.mumentB7B12)
    }
    private var backgroundImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
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
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: OnboardingModel){
        phraseLabel.text = cellData.phrase
        backgroundImageView.image = cellData.backgroundImage
        
    }
}

// MARK: - UI
extension OnboardingCVC {
    
    private func setLayout() {
        self.backgroundView = backgroundImageView
        self.addSubviews([phraseLabel])

        phraseLabel.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(123)
//            $0.width.equalTo(49)
//            $0.height.equalTo(24)
        }
    }
}

