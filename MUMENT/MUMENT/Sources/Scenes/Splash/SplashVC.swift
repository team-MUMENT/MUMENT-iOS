//
//  SplashVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

class SplashVC: UIViewController {
    
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
extension SplashVC {
    
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
extension SplashVC {
    private func requestTokenRenewal() {
        AuthAPI.shared.getRenewedToken() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? TokenRenewalResponseModel {
                    UserInfo.shared.accessToken = res.accessToken
                    UserInfo.shared.refreshToken = res.refreshToken
                    
                    UserDefaultsManager.accessToken = res.accessToken
                    UserDefaultsManager.refreshToken = res.refreshToken
                }
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
}
