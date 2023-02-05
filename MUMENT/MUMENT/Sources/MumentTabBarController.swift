//
//  MumentTabbarController.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then

final class MumentTabBarController: UITabBarController {
    
    // MARK: Components
    private let backgroundView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "mumentTabBarBG")
    }
    
    private var previousTabBarItemTag = 0
    private var isFromHomeTab = false
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItemStyle()
        self.setTabBar()
        self.setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setTabBarHeight()
    }
    
    /// TabBarItem 생성해 주는 메서드
    private func makeTabVC(vc: UIViewController, tabBarTitle: String, tabBarImg: String, tabBarSelectedImg: String) -> UIViewController {
        
        vc.tabBarItem = UITabBarItem(title: tabBarTitle,
                                     image: UIImage(named: tabBarImg)?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: tabBarSelectedImg)?.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        return vc
    }
    
    /// TabBarItem을 지정하는 메서드
    private func setTabBar() {
        self.delegate = self
        
        let homeTab = makeTabVC(vc: BaseNC(rootViewController: HomeVC()), tabBarTitle: "홈", tabBarImg: "mumentIconHomeOff", tabBarSelectedImg: "mumentIconHomeOn")
        homeTab.tabBarItem.tag = 0
        
        let writeTab = makeTabVC(vc: UIViewController(), tabBarTitle: "", tabBarImg: "mumentNavibarPlus", tabBarSelectedImg: "mumentNavibarPlus")
        writeTab.tabBarItem.tag = 1
        writeTab.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 9, right: 0)
        
        let storageTab = makeTabVC(vc: BaseNC(rootViewController: StorageVC()), tabBarTitle: "보관함", tabBarImg: "mumentIconLibraryOff", tabBarSelectedImg: "mumentIconLibraryOn")
        storageTab.tabBarItem.tag = 2
        
        let tabs = [homeTab, writeTab, storageTab]
        self.setViewControllers(tabs, animated: false)
    }
    
    func hideTabbar() {
        self.tabBar.isHidden = true
        self.backgroundView.isHidden = true
    }
    
    func showTabbar() {
        self.tabBar.isHidden = false
        self.backgroundView.isHidden = false
    }
}

// MARK: - UI
extension MumentTabBarController {
    
    /// TabBar의 height을 설정하는 메서드
    private func setTabBarHeight() {
        let height = self.view.safeAreaInsets.bottom + 48
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        backgroundView.frame = tabBar.frame
    }
    
    /// TabBarItem 스타일을 지정하는 메서드
    private func setTabBarItemStyle() {
        tabBar.tintColor = .mPurple1
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.mumentB8M12], for: .normal)
    }
    
    /// TabBar의 UI를 지정하는 메서드
    private func setTabBarUI() {
        let appearance = self.tabBar.standardAppearance
        appearance.shadowColor = nil
        appearance.shadowImage = nil
        appearance.backgroundImage = nil
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .clear
        self.tabBar.standardAppearance = appearance
        
        self.backgroundView.addShadow(location: .top)
        self.view.addSubviews([backgroundView])
        self.view.bringSubviewToFront(self.tabBar)
    }
}

// MARK: - UITabBarControllerDelegate
extension MumentTabBarController: UITabBarControllerDelegate {
    
    /// 1번 인덱스인 기록하기를 눌렀을 때, WriteVC를 present하기 위함
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let writeIndex = 1
        if viewController.tabBarItem.tag != writeIndex { return true }
        /// 이전 탭이 홈 일때 기록하기로 넘어가기전 타이머 종료 post
        if previousTabBarItemTag == 0 {
            self.isFromHomeTab = true
            NotificationCenter.default.post(name: .sendViewState, object: false)
        }else {
            self.isFromHomeTab = false
        }
        
        if let navigationVC = self.selectedViewController as? BaseNC, let topVC = navigationVC.topViewController as? BaseVC {
            if topVC.isPenaltyUser() {
                topVC.checkUserPenalty(topVC)
            } else {
                let writeVC = WriteVC(isEdit: false, isFromHomeTab: self.isFromHomeTab)
                viewController.present(writeVC, animated: true)
            }
        } else {
            debugPrint("not navigtaion")
        }
        return false
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        previousTabBarItemTag = viewController.tabBarItem.tag
    }
}
