//
//  SplashVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then
import Lottie

final class SplashVC: BaseVC {
    
    // MARK: Components
    private let animationView: LottieAnimationView = {
        let view: LottieAnimationView = LottieAnimationView(name: "logo_lottie")
        view.loopMode = .playOnce
        view.animationSpeed = 0.9
        return view
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundImage()
        self.setAnimationViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.animationView.play() { [weak self] _ in
            self?.decideNextVC()
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
        backgroundImageView.image = UIImage(named: "splashBackgroundImage")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(-3)
        }
    }
    
    private func setAnimationViewLayout() {
        self.view.addSubview(animationView)
        
        self.animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(101.adjustedH)
            make.height.equalTo(111.adjustedH)
        }
    }
}

// MARK: - Network
extension SplashVC {
    private func requestTokenRenewal() {
        self.startActivityIndicator()
        AuthAPI.shared.getRenewedToken() { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? TokenRenewalResponseModel {
                    self.setUserInfo(accessToken: res.accessToken, refreshToken: res.refreshToken, userId: res.id)
                }
                self.requestIsProfileSet()
            case .requestErr, .serverErr:
                self.stopActivityIndicator()
                let signInVC = SignInVC()
                signInVC.modalPresentationStyle = .fullScreen
                signInVC.modalTransitionStyle = .crossDissolve
                self.present(signInVC, animated: true)
            default:
                self.stopActivityIndicator()
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
                    self.stopActivityIndicator()
                } else if (status as! Int == 200) {
                    let setProfileVC = SetProfileVC()
                    setProfileVC.isFirst = true
                    setProfileVC.modalPresentationStyle = .fullScreen
                    setProfileVC.modalTransitionStyle = .crossDissolve
                    self.present(setProfileVC, animated: true)
                    self.stopActivityIndicator()
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
