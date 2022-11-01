//
//  SignInVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import UIKit
import Then
import SnapKit
import SafariServices

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
        setPrivacyPolicyLabelTapRecognizer()
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        kakaoSignInButton.press{
            print("카카오로 계속하기 버튼 클릭됨")
        }
        
        appleSignInButton.press{
            print("Apple로 계속하기 버튼 클릭됨")
        }
    }
    
    private func setPrivacyPolicyLabelTapRecognizer() {
        privacyPolicyLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(privacyPolicyLabelTapped)
        )
//        let tapGestureRecognizer2 = UITapGestureRecognizer(
//            target: self,
//            action: #selector(agreementLabelTapped)
//        )
        privacyPolicyLabel.addGestureRecognizer(tapGestureRecognizer)
//        privacyPolicyLabel.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    // TODO: - 연결될 웹페이지 링크 차후 노션 링크로 변경하기
    @objc private func privacyPolicyLabelTapped(_ sender: UITapGestureRecognizer) {
        
        // privacyPolicyLabel에서 UITapGestureRecognizer로 선택된 부분의 CGPoint를 구합니다.
        let point = sender.location(in: privacyPolicyLabel)
        
        if let calaulatedRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "이용약관과") {
            let agreementRect = CGRect(x: calaulatedRect.origin.x + 40, y: calaulatedRect.origin.y, width: calaulatedRect.width - 10, height: calaulatedRect.height)
            if agreementRect.contains(point) {
                print(agreementRect)
                present(url:  "https://www.google.com")
            }
        }
        
        if let personalInfoPolicyRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "개인정보처리방침"),
           personalInfoPolicyRect.contains(point) {
            print(personalInfoPolicyRect)
            present(url: "https://www.github.com")
        }
    }
    
//    @objc private func agreementLabelTapped(_ sender: UITapGestureRecognizer) {
        
        // privacyPolicyLabel에서 UITapGestureRecognizer로 선택된 부분의 CGPoint를 구합니다.
//        let point = sender.location(in: privacyPolicyLabel)
        //        print(privacyPolicyLabel.boundingRectForCharacterRange(subText: "이용약관과"))
        // privacyPolicyLabel 내에서 문자열 '이용약관'이 차지하는 CGRect값을 구해, 그 안에 point가 포함되는지를 판단합니다.
        
    
        //        if let agreementRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "이용약관과"),
        //           agreementRect.contains(point) {
        //            print(agreementRect)
        //            present(url:  "https://www.google.com")
        //        }
//    }
    
    private func present(url string: String) {
        if let url = URL(string: string) {
            let viewController = SFSafariViewController(url: url)
            present(viewController, animated: true)
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
