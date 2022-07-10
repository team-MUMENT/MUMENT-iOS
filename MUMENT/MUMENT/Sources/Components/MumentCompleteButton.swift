//
//  MumentCompleteButton.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/10.
//

import UIKit
import Then
import SnapKit

class MumentCompleteButton: UIButton {
    
    // MARK: - Initialization
    init(isEnabled: Bool) {
        super.init(frame: .zero)
        setDefaultStyle(isEnabled: isEnabled)
    }
    
    required init(coder aDecoder: NSCoder, isEnabled: Bool) {
        super.init(coder: aDecoder)!
        setDefaultStyle(isEnabled: isEnabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setDefaultStyle(isEnabled: Bool) {
        self.isEnabled = isEnabled
        self.makeRounded(cornerRadius: 11.adjustedH)
        self.setBackgroundColor(.mPurple1, for: .normal)
        self.setBackgroundColor(.mGray2, for: .disabled)
        self.setTitleColor(.mWhite, for: .normal)
        self.titleLabel?.font = .mumentH2B18
    }
}
