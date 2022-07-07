//
//  BaseNVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

class BaseNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}


extension BaseNC: UIGestureRecognizerDelegate {
    
    /// NavigationBar를 안 쓰고 UIView로 네비바를 구현할 때, 스와이프로 뒤로 가기 가능하게 함
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
