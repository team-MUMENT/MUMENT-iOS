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
        self.tabBarController?.tabBar.isHidden = true
        guard let subviews = self.tabBarController?.view.subviews else { return }
        let count = subviews.count
        let subview = subviews[count - 2]
        subview.isHidden.toggle()
    }
    
    func showTabbar() {
        self.tabBarController?.tabBar.isHidden = false
        guard let subviews = self.tabBarController?.view.subviews else { return }
        let count = subviews.count
        let subview = subviews[count - 2]
        subview.isHidden.toggle()
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
