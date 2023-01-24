//
//  AutoSignInVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

class AutoSignInVC: UIViewController {
    
    // MARK: - Properties
    private let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "mumentIcon")
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            
            self.decideNextVC()
//            let tabBarControlller = MumentTabBarController()
//            tabBarControlller.modalPresentationStyle = .fullScreen
//            tabBarControlller.modalTransitionStyle = .crossDissolve
//            self.present(tabBarControlller, animated: true)
        }
    }
    
    private func decideNextVC() {
//        UserDefaultsManager.refreshToken = nil
        let refreshToken = UserDefaultsManager.refreshToken
        print("REFRESH TOKEN", refreshToken)
        if (refreshToken == nil) {
            let onboardingVC = OnboardingVC()
            onboardingVC.modalPresentationStyle = .fullScreen
            onboardingVC.modalTransitionStyle = .crossDissolve
            self.present(onboardingVC, animated: true)
        } else {
            requestTokenRenewal()
        }
    }
}

// MARK: - UI
extension AutoSignInVC {
    
    private func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "splashBackground")
        backgroundImageView.contentMode = .scaleAspectFit
        self.view.addSubview(backgroundImageView)
    }
    
    private func setLayout() {
        view.addSubviews([logoImageView])
        
        logoImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(295)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Network
extension AutoSignInVC {
    private func requestTokenRenewal() {
        AuthAPI.shared.getRenewedToken() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? TokenRenewalResponseModel {
                    print("")
                    UserInfo.shared.accessToken = res.accessToken
                    UserInfo.shared.refreshToken = res.refreshToken
                    
                    UserDefaultsManager.accessToken = res.accessToken
                    UserDefaultsManager.refreshToken = res.refreshToken
                }
//                self.requestIsProfileSet()
                let tabBarController = MumentTabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
                tabBarController.modalTransitionStyle = .crossDissolve
                self.present(tabBarController, animated: true)
                
            case .requestErr(_, let message):
                if (message as! String == "만료된 토큰 입니다.") {
                    let signInVC = SignInVC()
                    signInVC.modalPresentationStyle = .fullScreen
                    signInVC.modalTransitionStyle = .crossDissolve
                    self.present(signInVC, animated: true)
                }
                else if (message as! String == "프로필 설정이 완료되지 않은 유저입니다") {
                    let setProfileVC = SetProfileVC()
                    setProfileVC.modalPresentationStyle = .fullScreen
                    setProfileVC.modalTransitionStyle = .crossDissolve
                    self.present(setProfileVC, animated: true)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
//    private func requestIsProfileSet() {
//        
//        AuthAPI.shared.getIsProfileSet() { networkResult in
//            switch networkResult {
//            case .success(let status):
//                print("SUCCESS")
//                if (status as! Int == 204) {
//                    let tabBarController = MumentTabBarController()
//                    tabBarController.modalPresentationStyle = .fullScreen
//                    tabBarController.modalTransitionStyle = .crossDissolve
//                    self.present(tabBarController, animated: true)
//                }
//            case .requestErr(let status, _):
//                if (status as! Int == 401) {
//                    print("REQUESTERR")
//                    let setProfileVC = SetProfileVC()
//                    setProfileVC.modalPresentationStyle = .fullScreen
//                    setProfileVC.modalTransitionStyle = .crossDissolve
//                    self.present(setProfileVC, animated: true)
//                }
//            default:
//                self.makeAlert(title: MessageType.networkError.message)
//            }
//        }
//    }
}

//enum TokenRenewalResult {
//    case refreshTokenExpired
//    case success
//}
//
//// MARK: - Network
//extension AutoSignInVC {
//
//    private func requestSignIn() {
//        let isAppleLogin = UserDefaultsManager.isAppleLogin
//        let userID = UserDefaultsManager.userId ?? ""
//
////        let socialID = isAppleLogin ? "Apple@\(userID)" : "Kakao@\(userID)"
////        let fcmToken = UserDefaultsManager.fcmToken ?? ""
//
//        AuthAPI(viewController: self).login(socialID: socialID, fcmToken: fcmToken) { response in
//            switch response {
//            case .success(let data):
//                if let data = data as? Login {
//                    if data.isNew {
//                        // 회원가입을 하지 않은 사용자입니다.
//                        self.presentToLoginVC()
//                    } else {
//                        // 회원 정보를 불러왔습니다.
//                        UserDefaultsManager.accessToken = data.accesstoken
//
//                        self.presentToMainTBC()
//                    }
//                }
//            case .requestErr(let message):
//                print("doorBellWithAPI - requestErr: \(message)")
//            case .pathErr:
//                print("doorBellWithAPI - pathErr")
//            case .serverErr:
//                print("doorBellWithAPI - serverErr")
//            case .networkFail:
//                print("doorBellWithAPI - networkFail")
//            }
//        }
//
//        AuthAPI.shared.postSignIn(body: SignInBodyModel(provider: <#T##String#>, authentication_code: <#T##String#>)) { networkResult in
//            switch networkResult {
//            case .success(let response):
//                if let res = response as? SignInResponseModel {
////                    UserInfo.shared.accessToken = res.accessToken
////                    UserInfo.shared.accessToken = res.refreshToken
////                    UserInfo.shared.userId = res.id
//
//                    UserDefaultsManager.accessToken = res.accessToken
//                    UserDefaultsManager.refreshToken = res.refreshToken
//                    UserDefaultsManager.userId = res.id
//                    UserDefaultsManager.isAppleLogin = data.provider == "apple" ? true : false
//                }
//            default:
//                self.makeAlert(title: MessageType.networkError.message)
//            }
//        }
//    }
//}
