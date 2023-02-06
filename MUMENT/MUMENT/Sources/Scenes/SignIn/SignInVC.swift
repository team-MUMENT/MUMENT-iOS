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
    
    // MARK: Components
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
    
    // MARK: Properties
    private var termsAndPolicyURL: GetAppURLresponseModel = GetAppURLresponseModel()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setLayout()
        setButtonActions()
        setPrivacyPolicyLabelTapRecognizer()
        self.getTermsAndPrivacyURL()
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        kakaoSignInButton.press{
            
            // 카카오톡 설치 여부 확인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    let fcmToken: String = UserDefaultsManager.fcmToken ?? ""
                    self.requestSignIn(data: SignInBodyModel(provider: "kakao", authentication_code: oauthToken?.accessToken ?? "", fcm_token: fcmToken))
                }
            }
            
            // 테스트용 카카오 로그인 탈퇴 코드
//                        if (UserApi.isKakaoTalkLoginAvailable()) {
//
//                            UserApi.shared.unlink {(error) in
//                                if let error = error {
//                                    print(error)
//                                }
//                                else {
//                                    print("unlink() success.")
//                                }
//                            }
//                        }
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
                present(url: self.termsAndPolicyURL.tos ?? "")
            }
        }
        
        // privacyPolicyLabel 내에서 문자열 '개인정보처리방침'이 차지하는 CGRect값을 구해, 그 안에 point가 포함되는지를 판단합니다.
        if let personalInfoPolicyRect = privacyPolicyLabel.boundingRectForCharacterRange(subText: "개인정보처리방침"),
           personalInfoPolicyRect.contains(point) {
            present(url: self.termsAndPolicyURL.privacy ?? "")
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
            
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if // let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
//               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                let fcmToken = UserDefaultsManager.fcmToken ?? ""
                requestSignIn(data: SignInBodyModel(provider: "apple", authentication_code: tokenString, fcm_token: fcmToken))
            }
        default:
            break
        }
    }
    
    /// 사용자 인증 실패 시 에러 처리를 합니다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple 로그인 사용자 인증 실패")
        print("error \(error)")
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
    
    /// 애플 로그인 UI를 어디에 띄울지 가장 적합한 뷰 앵커를 반환합니다.
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - Network
extension SignInVC {
    private func requestSignIn(data: SignInBodyModel) {
        AuthAPI.shared.postSignIn(body: data) { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? SignInResponseModel {
                    print("INNNNN")
                    self.setUserInfo(
                        accessToken: res.accessToken,
                        refreshToken: res.refreshToken,
                        userId: res.id
                    )
                    
                    if (res.type == "signUp") {
                        let setProfileVC = SetProfileVC()
                        setProfileVC.modalPresentationStyle = .fullScreen
                        setProfileVC.modalTransitionStyle = .crossDissolve
                        self.present(setProfileVC, animated: true)
                    } else {
                        self.requestIsProfileSet()
                    }
                    
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestIsProfileSet() {
        AuthAPI.shared.getIsProfileSet() { networkResult in
            switch networkResult {
            case .success(let status):
                print("SUCCESS")
                if (status as! Int == 204) {
                    let tabBarController = MumentTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    tabBarController.modalTransitionStyle = .crossDissolve
                    self.present(tabBarController, animated: true)
                } else if (status as! Int == 200) {
                    let setProfileVC = SetProfileVC()
                    setProfileVC.isFirst = true
                    setProfileVC.modalPresentationStyle = .fullScreen
                    setProfileVC.modalTransitionStyle = .crossDissolve
                    self.present(setProfileVC, animated: true)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func getTermsAndPrivacyURL() {
        MyPageAPI.shared.getMypageURL(isFromSignIn: true) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetAppURLresponseModel {
                    self.termsAndPolicyURL = result
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
