//
//  BaseVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SafariServices
import MessageUI

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    lazy var activityIndicator: MumentActivityIndicatorView = {
        let activityIndicator: MumentActivityIndicatorView = MumentActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.view.center
        
        return activityIndicator
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
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
    
    func startActivityIndicator() {
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension BaseVC: MFMailComposeViewControllerDelegate {
    func sendContactMail() {
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients(["mument.mp3@gmail.com"])
            compseVC.setSubject("[MUMENT] 문의해요 🙋")
            compseVC.setMessageBody(
"""
안녕하세요, 뮤멘트입니다.
문의하실 내용을 하단에 작성해주세요.
문의에 대한 답변은 전송해주신 메일로 회신드리겠습니다.
감사합니다.
——————————————————————————





——————————————————————————
User: \(String(describing: UserInfo.shared.userId ?? -1))
App Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
Device: \(deviceModelName())
OS Version: \(UIDevice.current.systemVersion)
"""
                , isHTML: false)
            
            self.present(compseVC, animated: true, completion: nil)
            
        } else {
            self.makeAlert(title: MessageType.unabledMailApp.message)
        }
    }
    
    func deviceModelName() -> String {
        
        /// 시뮬레이터 확인
        var modelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? ""
        if modelName.isEmpty == false && modelName.count > 0 {
            return modelName
        }
        
        /// 실제 디바이스 확인
        let device = UIDevice.current
        let selName = "_\("deviceInfo")ForKey:"
        let selector = NSSelectorFromString(selName)
        
        if device.responds(to: selector) {
            modelName = String(describing: device.perform(selector, with: "marketing-name").takeRetainedValue())
        }
        return modelName
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            switch result {
            case .cancelled, .saved: return
            case .sent:
                self.makeAlert(title: MessageType.completedSendContactMail.message)
            case .failed:
                self.makeAlert(title: MessageType.failedSendContactMail.message)
            @unknown default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
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
        self.startActivityIndicator()
        LikeAPI.shared.postHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let response):
                self.stopActivityIndicator()
                if let result = response as? LikeResponseModel {
                    completion(result)
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    func requestDeleteHeartLiked(mumentId: Int, completion: @escaping (LikeCancelResponseModel) -> ()) {
        self.startActivityIndicator()
        LikeAPI.shared.deleteHeartLiked(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let response):
                self.stopActivityIndicator()
                if let result = response as? LikeCancelResponseModel {
                    completion(result)
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
