//
//  BaseVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SafariServices

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.center = view.center
        
        // 기타 옵션
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        setMumentBackGroundColor()
    }
}

// MARK: - Custom Methods
extension BaseVC {
    func hideTabbar() {
        if let tabBarController = self.tabBarController as? MumentTabBarController {
            tabBarController.hideTabbar()
        }
    }
    
    func showTabbar() {
        if let tabBarController = self.tabBarController as? MumentTabBarController {
            tabBarController.showTabbar()
        }
    }
    
    /// 화면 터치시 키보드 내리는 메서드
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setMumentBackGroundColor() {
        view.backgroundColor = .mBgwhite
    }
    
    func openSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .pageSheet
        
        self.present(safariVC, animated: true)
    }
    
    func setUserInfo(
        accessToken: String?,
        refreshToken: String?,
        userId: Int?
    ) {
        UserInfo.shared.accessToken = accessToken
        UserInfo.shared.refreshToken = refreshToken
        UserInfo.shared.userId = userId
        
        UserDefaultsManager.accessToken = accessToken
        UserDefaultsManager.refreshToken = refreshToken
        UserDefaultsManager.userId = userId
    }
    
    func setUserProfile(nickname: String, profileImageURL: String) {
        UserInfo.shared.nickname = nickname
        UserInfo.shared.profileImageURL = profileImageURL
    }
    
    func removeUserInfo() {
        UserDefaultsManager.accessToken = nil
        UserDefaultsManager.refreshToken = nil
        UserDefaultsManager.userId = nil
        UserInfo.shared = UserInfo.init()
    }
    
    func getUserProfile(completion: @escaping () -> (Void)) {
        MyPageAPI.shared.getUserProfile { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetUserProfileResponseModel {
                    self.setUserProfile(nickname: result.userName, profileImageURL: result.image)
                    completion()
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func getUserPenalty(completion: @escaping (GetUserPenaltyResponseModel) -> (Void)) {
        HomeAPI.shared.getUserPenalty { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetUserPenaltyResponseModel {
                    completion(result)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    func checkUserPenalty(_ targetVC: UIViewController) {
        self.getUserPenalty { responsePenaltyData in
            UserInfo.shared.isPenaltyUser = responsePenaltyData.restricted
            if self.isPenaltyUser() {
                targetVC.present(MumentUserPenaltyAlert(penaltyData: responsePenaltyData), animated: true)
            }
        }
    }
    
    func isPenaltyUser() -> Bool {
        return UserInfo.shared.isPenaltyUser
    }
}

// MARK: - Custom Methods(화면전환)
extension BaseVC {
    
    /// 특정 탭의 루트 뷰컨으로 이동시키는 메서드
    func goToRootOfTab(index: Int) {
        tabBarController?.selectedIndex = index
        if let nav = tabBarController?.viewControllers?[index] as? UINavigationController {
            nav.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Network
extension BaseVC {
    func requestPostHeartLiked(mumentId: Int, completion: @escaping (LikeResponseModel) -> ()) {
        LikeAPI.shared.postHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? LikeResponseModel {
                    completion(result)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    func requestDeleteHeartLiked(mumentId: Int, completion: @escaping (LikeCancelResponseModel) -> ()) {
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? LikeCancelResponseModel {
                    completion(result)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
