//
//  MumentTabbarController.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit

class MumentTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItemStyle()
        setShadow()
        setTabBar()
    }
}

// MARK: - UI
extension MumentTabBarController {
    
    func makeTabVC(vc: UIViewController, tabBarTitle: String, tabBarImg: String, tabBarSelectedImg: String) -> UIViewController {
        
        vc.tabBarItem = UITabBarItem(title: tabBarTitle,
                                     image: UIImage(named: tabBarImg)?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: tabBarSelectedImg)?.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        return vc
    }
    
    func setTabBarItemStyle() {
        tabBar.tintColor = .mPurple1
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.mumentB5M12], for: .normal)
    }
    
    func setShadow() {
        UITabBar.clearShadow()
        tabBar.layer.setShadow(color: .mShadow, alpha: 1, x: 0, y: -3, blur: 10)
    }
    
    func setTabBar() {
        let homeTab = makeTabVC(vc: HomeVC(), tabBarTitle: "홈", tabBarImg: "mumentIconHomeOff", tabBarSelectedImg: "mumentIconHomeOn")
        let writeTab = makeTabVC(vc: WriteVC(), tabBarTitle: "기록하기", tabBarImg: "mumentIconRecordOff", tabBarSelectedImg: "mumentIconRecordOn")
        let storageTab = makeTabVC(vc: StorageVC(), tabBarTitle: "보관함", tabBarImg: "mumentIconLibraryOff", tabBarSelectedImg: "mumentIconLibraryOn")
        
        let tabs = [homeTab, writeTab, storageTab]
        self.setViewControllers(tabs, animated: false)
    }
}
