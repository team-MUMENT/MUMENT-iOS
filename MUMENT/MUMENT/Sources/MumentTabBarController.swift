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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItemStyle()
        self.setShadow()
        self.setTabBar()
        self.requestSignIn()
    }
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
        
        let writeTab = makeTabVC(vc: WriteVC(), tabBarTitle: "", tabBarImg: "mumentNavibarPlus", tabBarSelectedImg: "mumentNavibarPlus")
        writeTab.tabBarItem.tag = 1
        writeTab.tabBarItem.imageInsets = UIEdgeInsets(top: -7, left: 0, bottom: 9, right: 0)
        
        let storageTab = makeTabVC(vc: StorageVC(), tabBarTitle: "보관함", tabBarImg: "mumentIconLibraryOff", tabBarSelectedImg: "mumentIconLibraryOn")
        storageTab.tabBarItem.tag = 2
        
        let tabs = [homeTab, writeTab, storageTab]
        self.setViewControllers(tabs, animated: false)
    }
}

        tabBar.tintColor = .mPurple1
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.mumentB8M12], for: .normal)
    }
    
    func setShadow() {
        UITabBar.clearShadow()
        tabBar.layer.setShadow(color: .mShadow, alpha: 1, x: 0, y: -3, blur: 10)
    }

// MARK: - UITabBarControllerDelegate
extension MumentTabBarController: UITabBarControllerDelegate {
    
    /// 1번 인덱스인 기록하기를 눌렀을 때, WriteVC를 present하기 위함
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let writeIndex = 1
        if viewController.tabBarItem.tag != writeIndex { return true }
        
        let writeVC = WriteVC()
        writeVC.modalPresentationStyle = .overFullScreen
        viewController.present(writeVC, animated: true)
        return false
    }
}

// MARK: - Network
extension MumentTabBarController {
    private func requestSignIn() {
        SignAPI.shared.postSignIn(body: SignInBodyModel(profileId: "iangOS", password: "lovemument")) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? SignInDataModel {
                    UserInfo.shared.userId = result.id
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
