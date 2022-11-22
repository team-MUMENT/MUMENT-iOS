//
//  PageControl.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/21.
//

import UIKit

class OnboardingPageControl: UIPageControl {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentView = self.subviews

        for subview in contentView[0].subviews[0].subviews {
            if let subview = subview as? UIImageView {
                subview.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        }
    }
}
