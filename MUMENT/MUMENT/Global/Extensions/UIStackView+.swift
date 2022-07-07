//
//  UIStackView+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
