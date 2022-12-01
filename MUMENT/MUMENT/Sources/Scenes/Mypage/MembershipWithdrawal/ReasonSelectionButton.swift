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

    private var buttonTitleLabel = UILabel().then{
        $0.textColor =  .mGray1
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
    
    // MARK: - UI
    private func setUI(title: String) {
//        self.isEnabled = isEnabled
//        self.makeRounded(cornerRadius: 11.adjustedH)
//        self.setBackgroundColor(.mGray5, for: .normal)
//        self.setTitleColor(.mGray1, for: .normal)
//        self.titleLabel?.font = .

//        self.setBackgroundImage(UIImage(named: "dropDownButton_selected"), for: .normal)
//        var configuration = UIButton.Configuration.
//        configuration.image = UIImag/e(named: "dropDownButton_unselected")
//        configuration.titleAlignment = .leading
//        self.configuration = configuration
//        self.setTitleWithCustom(title, font: .mumentB3M14, color: .mGray1, for: .normal)
//        self.layer.borderColor = UIColor.mGray3.cgColor
        self.setBackgroundImage(UIImage(named: "dropDownButton_unselected"), for: .normal)
        buttonTitleLabel.text = title
    }
}

// MARK: - UI
extension DropDownButton {

    private func setLayout() {
        self.addSubview(buttonTitleLabel)

        buttonTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(13)
            $0.centerY.equalToSuperview()
        }
    }
}
