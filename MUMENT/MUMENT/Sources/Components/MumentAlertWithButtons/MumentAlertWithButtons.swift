//
//  MumentAlertWithButtons.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/17.
//

import UIKit
import SnapKit
import Then


class MumentAlertWithButtons: BaseVC{
    
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
    let OKButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .mumentB4M14
        $0.setTitleColor(.mPurple1, for: .normal)
    }
    
    var titleType: MumentAlertTitleType?
    var alertHeight: CGFloat?
    
    // MARK: - Initialization
    init(titleType: MumentAlertTitleType) {
        super.init(nibName: nil, bundle: nil)
        
        setPresentation()
        self.titleType = titleType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setButtonAction()()
        setDefaultLayout()
        
        setButtonStackViewLayout()
        setAlertLayout()
        
        switch self.titleType {
        case .onlyTitleLabel:
            self.setOnlyTitleContentStackViewLayout()
        case .containedSubTitleLabel:
            self.setContainedSubTitleContentStackViewLayout()
        case .none:
            self.setOnlyTitleContentStackViewLayout()
        }
    }
    
    // MARK: - Functions
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setTitleSubTitle(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    func setPresentation() {
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
            $0.width.equalTo(screenWidth * 0.717333)
            $0.height.equalTo(alertHeight ?? 0.0)
            $0.center.equalToSuperview()
        }
    }
    
    private func setAlertLayout() {
        alertView.addSubviews([contentStackView, buttonStackView])
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo((self.alertHeight ?? 0) * 0.35)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setOnlyTitleContentStackViewLayout() {
        contentStackView.addArrangedSubviews([titleLabel])
        
        contentStackView.snp.makeConstraints {
            print(alertView.frame.height)
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top)
        }
    }
    
    private func setContainedSubTitleContentStackViewLayout() {
        contentStackView.addArrangedSubviews([titleLabel, subTitleLabel])
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset((alertHeight ?? 0) * 0.25)
            $0.left.right.equalToSuperview()
            $0.height.equalTo((alertHeight ?? 0) * 0.25)
        }
    }
    
    private func setButtonStackViewLayout() {
        buttonStackView.addArrangedSubviews([cancelButton, OKButton])
    }
}
