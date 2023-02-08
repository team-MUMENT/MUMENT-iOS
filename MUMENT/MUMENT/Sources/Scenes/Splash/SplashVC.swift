//
//  SplashVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

final class SplashVC: BaseVC {
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.decideNextVC()
        }
    }
    
    private func decideNextVC() {
        let refreshToken = UserDefaultsManager.refreshToken
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
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "splashImage")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(-3)
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
                    self.setUserInfo(accessToken: res.accessToken, refreshToken: res.refreshToken, userId: res.id)
                }
                self.requestIsProfileSet()
            case .requestErr, .serverErr:
                let signInVC = SignInVC()
                signInVC.modalPresentationStyle = .fullScreen
                signInVC.modalTransitionStyle = .crossDissolve
                self.present(signInVC, animated: true)
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestIsProfileSet() {
        AuthAPI.shared.getIsProfileSet() { networkResult in
            switch networkResult {
            case .success(let status):
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
}
