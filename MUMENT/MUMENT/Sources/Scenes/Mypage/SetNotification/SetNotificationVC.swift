//
//  SetNotificationVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import UIKit
import SnapKit
import Then

final class SetNotificationVC: BaseVC {
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "알림 설정")
    }
    
    private let labelStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let titleLabel: UILabel = UILabel().then {
        $0.text = "알림"
        $0.font = .mumentH4M16
        $0.textColor = .mBlack1
    }
    
    private let infoLabel: UILabel = UILabel().then {
        $0.text = "누군가 내 뮤멘트에 좋아요했을 때, 중요한 공지사항, 마케팅 이벤트, 계정 상태에 대한 알림을 받을 수 있어요"
        $0.font = .mumentB8M12
        $0.textColor = .mGray1
        $0.numberOfLines = 0
    }
    
    private let toggleButton: MumentToggleButton = MumentToggleButton(type: .system).then {
        $0.removeTarget(nil, action: nil, for: .allTouchEvents)
    }
    
    // MARK: Properties
    var isOriginalSystemNotiSettingOn = false
    var isSystemNotiSettingOn = false
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButton()
    }
    
    
    // MARK: Methods
    private func setBackButton() {
        self.naviView.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - UI
extension SetNotificationVC {
    private func setLayout() {
        self.view.addSubviews([naviView, labelStackView, toggleButton])
        self.labelStackView.addArrangedSubviews([titleLabel, infoLabel])
        
        self.naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        self.toggleButton.snp.makeConstraints {
            $0.centerY.equalTo(self.labelStackView)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(49)
            $0.height.equalTo(self.toggleButton.snp.width).multipliedBy(0.571428)
        }
        
        self.labelStackView.snp.makeConstraints {
            $0.top.equalTo(self.naviView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(self.toggleButton.snp.leading).offset(-14)
        }
    }
}
