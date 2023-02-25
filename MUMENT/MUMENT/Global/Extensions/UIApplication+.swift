//
//  UIApplication+.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/26.
//

import UIKit

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        let vc = UIApplication.shared.connectedScenes.filter {
            $0.activationState == .foregroundActive
        }.first(where: { $0 is UIWindowScene })
            .flatMap( { $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)?
            .rootViewController?
            .topMostViewController()

        return vc
    }
}
