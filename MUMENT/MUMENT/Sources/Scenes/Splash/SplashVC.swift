//
//  SplashVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

final class SplashVC: UIViewController {
    
    // MARK: Components
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
        
        // 앱 처음 사용하는 경우 테스트
        //        UserDefaultsManager.refreshToken = nil
        
        // 리프레시 토큰 만료된 경우  테스트
        //        UserDefaultsManager.refreshToken =  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsInByb2ZpbGVJZCI6Iu2GoO2BsCDrp4zro4wg7YWM7Iqk7Yq4ISIsImltYWdlIjpudWxsLCJpYXQiOjE2NzM3MjE3ODQsImV4cCI6MTY3MzkwNTc4NCwiaXNzIjoiTXVtZW50In0.qthgxZav45JckbvFc9mw4LqtVhvP5MC2vTZ6Qu3qIIg"
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
                    print("!!!!!!11")
                    UserInfo.shared.accessToken = res.accessToken
                    UserInfo.shared.refreshToken = res.refreshToken
                    
                    UserDefaultsManager.accessToken = res.accessToken
                    UserDefaultsManager.refreshToken = res.refreshToken
                }
                self.requestIsProfileSet()
                
            case .requestErr(_, let message):
                if (message as! String == "토큰이 만료되었습니다") {
                    let signInVC = SignInVC()
                    signInVC.modalPresentationStyle = .fullScreen
                    signInVC.modalTransitionStyle = .crossDissolve
                    self.present(signInVC, animated: true)
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
                if (status as! Int == 204) {
                    let tabBarController = MumentTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    tabBarController.modalTransitionStyle = .crossDissolve
                    self.present(tabBarController, animated: true)
                } else if (status as! Int == 200) {
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
