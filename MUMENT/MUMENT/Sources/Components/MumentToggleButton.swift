//
//  MumentToggleButton.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import UIKit
import SnapKit
import Then

final class MumentToggleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "mumentToggleOff"), for: .normal)
        self.setImage(UIImage(named: "mumentToggleOn"), for: .selected)
        self.setBackgroundColor(.clear, for: .selected)
        self.tintColor = .clear
        self.press { [weak self] in
            self?.isSelected.toggle()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
