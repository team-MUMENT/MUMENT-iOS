//
//  ReasonSelectionButton.swift
//  MUMENT
//
//  Created by 김지민 on 2022/12/01.
//

import UIKit
import SnapKit
import Then

final class DropDownButton: UIButton {
    
    // MARK: - Components
    private var buttonTitleLabel = UILabel().then {
        $0.textColor = .mGray1
        $0.font = .mumentB3M14
    }
    
    // MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        setUI(title: title)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Functions
    func setTitleLabel(_ labelText: String) {
        buttonTitleLabel.text = labelText
        buttonTitleLabel.textColor = .mBlack1
    }
    
    func getTitleLabel() -> String {
        return buttonTitleLabel.text ?? "No Title Label"
    }
}

// MARK: - UI
extension DropDownButton {
    
    private func setUI(title: String) {
        self.setBackgroundImage(UIImage(named: "dropDownButton_unselected"), for: .normal)
        buttonTitleLabel.text = title
    }
    
    private func setLayout() {
        self.addSubview(buttonTitleLabel)
        
        buttonTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(13)
            $0.centerY.equalToSuperview()
        }
    }
}
