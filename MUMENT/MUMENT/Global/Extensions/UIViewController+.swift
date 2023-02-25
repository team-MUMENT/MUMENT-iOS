//
//  UIViewController+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit

enum DeviceType {
    case iPhoneSE2
    case iPhone8
    case iPhone13Pro
    case iPhone13mini
    
    func name() -> String {
        switch self {
        case .iPhoneSE2:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone13Pro:
            return "iPhone 13 Pro"
        case .iPhone13mini:
            return "iPhone 13 mini"
        }
    }
}

extension UIViewController {
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /**
     - Description: 화면 터치시 작성 종료
     */
    /// 화면 터치시 작성 종료하는 메서드
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     - Description: 화면 터치시 키보드 내리는 Extension
     */
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /**
     - Description: Alert
     */
    /// 확인 버튼 2개, 취소 버튼 1개 ActionSheet 메서드
    func makeTwoAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                                secondOkTitle: String, secondOkStyle: UIAlertAction.Style = .default,
                                cancelTitle: String = "취소",
                                okAction : ((UIAlertAction) -> Void)?, secondOkAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                                completion : (() -> Void)? = nil) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)
        
        let secondOkAction = UIAlertAction(title: secondOkTitle, style: secondOkStyle, handler: secondOkAction)
        alertViewController.addAction(secondOkAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인 버튼 1개, 취소 버튼 1개 Alert 메서드
    func makeAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                             cancelTitle: String = "취소",
                             okAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                             completion : (() -> Void)? = nil) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인 버튼 Alert 메서드
    func makeAlert(title : String, message : String? = nil,
                   okTitle: String = "확인", okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 신고 ActionSheet 메서드
    func reportActionSheet(completion: @escaping (String) -> ()) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)
        
        let reasonList: [String] = ["음란/욕설/분쟁", "유출/사칭/사기", "상업적 내용", "우리 학교/학과가 아닌 학생", "서비스 취지에 맞지 않는 글", "기타"]
        for i in 0...reasonList.count - 1 {
            alertViewController.addAction(UIAlertAction(title: reasonList[i], style: .default, handler: { (action) in
                completion(reasonList[i])
            }))
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    /**
     - Description:
     VC나 View 내에서 해당 함수를 호출하면, 햅틱이 발생하는 메서드입니다.
     버튼을 누르거나 유저에게 특정 행동이 발생했다는 것을 알려주기 위해 다음과 같은 햅틱을 활용합니다.
     
     - parameters:
     - degree: 터치의 세기 정도를 정의. 보통은 medium,light를 제일 많이 활용합니다.
     */
    func makeVibrate(degree : UIImpactFeedbackGenerator.FeedbackStyle = .medium)
    {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
    
    // MARK: - toast message 띄우기
    /// viewController에 message를 띄워 줍니다.
    ///
    ///- parameters:
    ///   - message: 화면에 보여질 메시지
    ///   - vc: 토스트 메시지가 띄워질 view controller
    func showToastMessage(message: String, color: ToastMessageColorType) {
        let width = 335.adjustedW
        var frame = CGRect()
        let toastLabel = UILabel()
        
        switch color {
        case .black:
            toastLabel.backgroundColor = .mBlack2
            toastLabel.textColor =  .mWhite
            frame = CGRect(x: self.view.frame.size.width / 2 - CGFloat(width) / 2, y: 675.adjustedH, width: CGFloat(width), height: 40)
        case .red:
            toastLabel.backgroundColor = .mRed.withAlphaComponent(0.4)
            toastLabel.textColor = .mBlack1
            frame = CGRect(x: self.view.frame.size.width / 2 - CGFloat(width) / 2, y: 107.adjustedH, width: CGFloat(width), height: 40)
        }
        
        toastLabel.frame = frame
        toastLabel.font = UIFont.mumentB8M12
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 2.0, options: .curveEaseInOut, animations: {
                toastLabel.alpha = 0.0
            }, completion:  { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
    
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleVC = navigation.visibleViewController {
                return visibleVC.topMostViewController()
            }
        }
        
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                if let baseNC = selectedTab as? BaseNC {
                    if let visibleVC = baseNC.visibleViewController {
                        return visibleVC.topMostViewController()
                    }
                }
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        if let presentVC = self.presentedViewController {
            return presentVC.topMostViewController()
        }
        return UIViewController()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func showPreview(_ deviceType: DeviceType = .iPhone13mini) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
