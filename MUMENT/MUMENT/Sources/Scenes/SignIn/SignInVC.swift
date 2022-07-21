//
//  SignInVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import UIKit
import Then
import SnapKit

class SignInVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        requestSignIn(body: SignInBodyModel(profileId: "mumentdsf", password: "mumentasdlf"))
       // 이렇게 쓰세요.
//        completeBtn.press { [weak self] in
//            self?.requestSignIn(body: self?.signData ?? SignBodyModel(name: "", email: "", password: ""), completion: { userName in
//                self?.makeAlert(title: "로그인 성공", message: "", okTitle: "확인", okAction: { alert in
//                    let tabBar = InstagramTBC()
//                    tabBar.modalPresentationStyle = .fullScreen
//                    self?.present(tabBar, animated: true)
//                })
//            })
//        }
    }
}

// MARK: - Network
extension SignInVC {
    private func requestSignIn(body: SignInBodyModel) {
        SignAPI.shared.postSignIn(body: body) { networkResult in
            switch networkResult {
            case .success(let response):
                if response is SignInBodyModel {
                    print(response)
                }
//            case .requestErr(_):
//                // 에러 처리...
//            case .pathErr:
//                // 에러 처리...
//            case .serverErr:
//                // 에러 처리...
//            case .networkFail:
//                // 에러 처리...
            default:
                self.makeAlert(title: """
네트워크 오류로 인해 연결에 실패했어요! 🥲
잠시 후에 다시 시도해 주세요.
""")
            }
        }
    }
}
