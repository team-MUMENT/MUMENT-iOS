//
//  UITableViewCell+.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/11.
//
import UIKit

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
