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
import KakaoSDKUser
import AuthenticationServices

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
    
    private let privacyPolicyLabel = UILabel().then{
        $0.font = .mumentB8M12
        $0.textColor = .mGray2
        $0.text = "로그인 시 이용약관과\n개인정보처리방침에 동의하게 됩니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.setHyperlinkedStyle(to: ["이용약관", "개인정보처리방침"], with: .mumentB7B12)
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
            
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")
                        
                        // TODO: - 서버한테 보내서 jwt 토큰 발급 받기
                        _ = oauthToken
                    }
                }
            }
        }
        
        appleSignInButton.press{
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
    
    private func setPrivacyPolicyLabelTapRecognizer() {
        privacyPolicyLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(privacyPolicyLabelTapped)
        )
        privacyPolicyLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // TODO: - 연결될 웹페이지 링크 차후 노션 링크로 변경하기
    @objc private func privacyPolicyLabelTapped(_ sender: UITapGestureRecognizer) {
        
        // privacyPolicyLabel에서 UITapGestureRecognizer로 선택된 부분의 CGPoint를 구합니다.
        let point = sender.location(in: privacyPolicyLabel)
        
        // privacyPolicyLabel 내에서 문자열 '이용약관'이 차지하는 CGRect값을 구해, 그 안에 point가 포함되는지를 판단합니다.
        if let calaulatedTermsRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "이용약관") {
            let actualTermsRect = CGRect(x: calaulatedTermsRect.origin.x + 40, y: calaulatedTermsRect.origin.y, width: calaulatedTermsRect.width - 10, height: calaulatedTermsRect.height)
            if actualTermsRect.contains(point) {
                present(url: "https://www.google.com")
            }
        }
        
        // privacyPolicyLabel 내에서 문자열 '개인정보처리방침'이 차지하는 CGRect값을 구해, 그 안에 point가 포함되는지를 판단합니다.
        if let personalInfoPolicyRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "개인정보처리방침"),
           personalInfoPolicyRect.contains(point) {
            present(url: "https://www.github.com")
        }
    }
    
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

// MARK: - ASAuthorizationControllerDelegate
extension SignInVC: ASAuthorizationControllerDelegate {
    
    /// 사용자 인증 성공 시 인증 정보를 반환 받습니다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            
            // 비밀번호 및 FaceID 인증 경우를 통해 왔을 때
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("userIdentifier", userIdentifier)
            print("fullName", fullName as Any)
            print("email", email as Any)
            
            // TODO: - 서버한테 보내서 jwt 토큰 발급 받기
            
            // iCloud의 패스워드를 연동해 왔을 때
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username", username)
            
            // TODO: - 서버한테 보내서 jwt 토큰 발급 받기
        default:
            break
        }
    }
    
    /// 사용자 인증 실패 시 에러 처리를 합니다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple 로그인 사용자 인증 실패")
        print("error \(error)")
        
        // 필요 시 추가적인 에러 처리
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
    
    /// 애플 로그인 UI를 어디에 띄울지 가장 적합한 뷰 앵커를 반환합니다.
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
