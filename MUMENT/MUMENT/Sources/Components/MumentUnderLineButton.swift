//
//  MumentUnderLineButton.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/30.
//

import UIKit
import Then

final class MumentUnderLineButton: UIButton {
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        self.titleLabel?.setHyperlinkedStyle(to: [title ?? ""], with: .mumentB8M12)
        self.setTitleColor(.mGray1, for: .normal)
    }
}
