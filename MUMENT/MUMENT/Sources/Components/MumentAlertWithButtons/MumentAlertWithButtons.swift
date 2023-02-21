//
//  MumentAlertWithButtons.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class MumentAlertWithButtons: BaseVC {
    
    enum MumentAlertButtonType {
        case one
        case two
    }
    
    // MARK: - Properties
    private let alertView = UIView().then {
        $0.backgroundColor = .mWhite
        $0.makeRounded(cornerRadius: 11.adjustedH)
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    private let titleLabel = UILabel().then {
        $0.text = "plz set title"
        $0.font = .mumentH3B16
        $0.textColor = .mBlack2
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    private let subTitleLabel = UILabel().then {
        $0.text = "plz set subTitle"
        $0.font = .mumentB8M12
        $0.textColor = .mBlack2
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    private let cancelButton = UIButton(type: .system).then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .mumentB4M14
        $0.setTitleColor(.mBlack2, for: .normal)
    }
    lazy var OKButton = UIButton(type: .system).then {
        $0.setTitle(okTitle ?? "확인", for: .normal)
        $0.titleLabel?.font = .mumentB4M14
        $0.setTitleColor(.mPurple1, for: .normal)
    }
    
    private var titleType: MumentAlertTitleType?
    private var buttonType: MumentAlertButtonType = .two
    private var alertHeight: CGFloat?
    private var okTitle: String? = nil
    
    // MARK: - Initialization
    init(titleType: MumentAlertTitleType, buttonType: MumentAlertButtonType = .two) {
        super.init(nibName: nil, bundle: nil)
        
        setPresentation()
        self.titleType = titleType
        self.buttonType = buttonType
    }
    
    init(titleType: MumentAlertTitleType, OKTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        setPresentation()
        self.titleType = titleType
        okTitle = OKTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
        self.setButtonAction()
        self.setDefaultLayout()
        
        self.setAlertLayout()
        
        switch self.titleType {
        case .onlyTitleLabel:
            self.setOnlyTitleContentStackViewLayout()
        case .containedSubTitleLabel:
            self.setContainedSubTitleContentStackViewLayout()
        case .none:
            self.setOnlyTitleContentStackViewLayout()
        }
        
        switch self.buttonType {
        case .one:
            self.setOnlyOKButtonLayout()
        case .two:
            self.setButtonStackViewLayout()
        }
    }
    
    // MARK: - Functions
    func setTitle(title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }
    
    func setTitleSubTitle(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
    }
    
    private func setPresentation() {
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    func setButtonAction() {
        cancelButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
        OKButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - UI
extension MumentAlertWithButtons {
    private func setUI() {
        self.view.backgroundColor = .mAlertBgBlack
        alertHeight = screenHeight * 0.227832
    }
    
    private func setDefaultLayout() {
        view.addSubviews([alertView])
        
        alertView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(53.adjustedW)
            $0.center.equalToSuperview()
        }
    }
    
    private func setAlertLayout() {
        alertView.addSubviews([contentStackView, buttonStackView])
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setOnlyTitleContentStackViewLayout() {
        contentStackView.addArrangedSubviews([titleLabel])
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-28)
        }
    }
    
    private func setContainedSubTitleContentStackViewLayout() {
        contentStackView.addArrangedSubviews([titleLabel, subTitleLabel])
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-23)
        }
    }
    
    private func setButtonStackViewLayout() {
        buttonStackView.addArrangedSubviews([cancelButton, OKButton])
    }
    
    private func setOnlyOKButtonLayout() {
        buttonStackView.addArrangedSubviews([OKButton])
    }
}
