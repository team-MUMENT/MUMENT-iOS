//
//  UINavigationController+.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/07.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
        self.viewControllers.count > 1 ? self.viewControllers[self.viewControllers.count - 2] : nil
    }
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
