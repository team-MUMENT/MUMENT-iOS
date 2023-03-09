//
//  AdminSignInVC.swift
//  MUMENT
//
//  Created by madilyn on 2023/03/10.
//

import UIKit
import SnapKit

final class AdminSignInVC: BaseVC {
    
    // MARK: Properties
    private let userIDTextField: MumentTextField = {
        let textField: MumentTextField = MumentTextField()
        textField.backgroundColor = .mBgwhite
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.mBlue1.cgColor
        textField.placeholder = "user ID를 입력해 주세요. 숫자만!!!!!!!!!!"
        return textField
    }()
    
    private let userNameTextField: MumentTextField = {
        let textField: MumentTextField = MumentTextField()
        textField.backgroundColor = .mBgwhite
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.mBlue1.cgColor
        textField.placeholder = "닉네임을 입력해 주세요."
        return textField
    }()
    
    private let signInButton: MumentCompleteButton = {
        let button: MumentCompleteButton = MumentCompleteButton(isEnabled: true)
        button.setTitle("로그인(제대로입력하고누르3)", for: .normal)
        return button
    }()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundImage()
        self.setLayout()
        self.setSignInButtonAction()
    }
    
    // MARK: Methods
    private func setSignInButtonAction() {
        self.signInButton.press { [weak self] in
            guard let userID: Int = Int(self?.userIDTextField.text ?? "")
            else {
                self?.makeAlert(title: "userID를 제대로 입력해 주세요.")
                return
            }
            
            self?.requestAdminSignIn(userID: userID, userName: self?.userNameTextField.text ?? "")
        }
    }
}

// MARK: - UI
extension AdminSignInVC {
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "signInBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
    }
    
    private func setLayout() {
        self.view.addSubviews([userIDTextField, userNameTextField, signInButton])
        
        self.userIDTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        self.userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.userIDTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(self.userNameTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

// MARK: - Network
extension AdminSignInVC {
    private func requestAdminSignIn(userID: Int, userName: String) {
        AuthAPI.shared.requestAdminSignIn(userID: userID, userName: userName) { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? SignInResponseModel {
                    UserDefaultsManager.isAppleLogin = false
                    UserInfo.shared.isAppleLogin = false
                    
                    self.setUserInfo(
                        accessToken: res.accessToken,
                        refreshToken: res.refreshToken,
                        userId: res.id
                    )
                    
                    let tabBarController = MumentTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    tabBarController.modalTransitionStyle = .crossDissolve
                    self.present(tabBarController, animated: true)
                }
            case .requestErr(_, let message):
                if let messageString = message as? String {
                    self.makeAlert(title: messageString)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
