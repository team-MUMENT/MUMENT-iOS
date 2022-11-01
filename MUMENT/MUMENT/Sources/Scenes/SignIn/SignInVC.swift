//
//  SignInVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import UIKit
import Then
import SnapKit

final class SignInVC: BaseVC {
    
    // MARK: - Properties
    private let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "mumentLogoLogin")
    }
    private let guidingLabel = UILabel().then{
        $0.font = .mumentB4M14
        $0.textColor = .mBlack2
        $0.text = "회원가입을 통해 나의 음악 감상을 쌓아보세요."
    }
    private let kakaoSignInButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "kakaoLogin"), for: .normal)
    }
    private let appleSignInButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "appleLogin"), for: .normal)
    }
    
    // TODO: - NSAttributedString 이용해서 스타일 바꾸고 링크 연결하기
    private let privacyPolicyLabel = UILabel().then{
        $0.font = .mumentB8M12
        $0.textColor = .mGray2
        $0.text = "로그인 시 이용약관과\n개인정보처리방침에 동의하게 됩니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.setHyperlinkedStyle(to: ["이용약관","개인정보처리방침"])
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setLayout()
        setButtonActions()
    }
    
    // MARK: - Functions
    func setButtonActions(){
        kakaoSignInButton.press{
            print("카카오로 계속하기 버튼 클릭됨")
        }
        
        appleSignInButton.press{
            print("Apple로 계속하기 버튼 클릭됨")
        }
    }
}

// MARK: - UI
extension SignInVC {
    private func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "signInBackground")
        backgroundImageView.contentMode = .scaleAspectFit
        self.view.addSubview(backgroundImageView)
    }
    
    private func setLayout() {
        view.addSubviews([logoImageView,guidingLabel,kakaoSignInButton,appleSignInButton,privacyPolicyLabel])
        
        logoImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(168)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        guidingLabel.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        kakaoSignInButton.snp.makeConstraints{
            $0.top.equalTo(guidingLabel.snp.bottom).offset(17)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        appleSignInButton.snp.makeConstraints{
            $0.top.equalTo(kakaoSignInButton.snp.bottom).offset(15)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        privacyPolicyLabel.snp.makeConstraints{
            $0.top.equalTo(appleSignInButton.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
