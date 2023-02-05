//
//  NotificationOnBottomVC.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/03.
//

import UIKit
import SnapKit

final class NotificationOnBottomVC: BaseVC {
    
    // MARK: UIComponents
    private let bottomView: UIView = {
        let view: UIView = UIView()
        view.makeRounded(cornerRadius: 11)
        view.backgroundColor = .mWhite
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "알림 설정하시고\n뮤멘트의 즐거움을 놓치지 마세요!"
        label.numberOfLines = 2
        label.font = .mumentH3B16
        label.textColor = .mBlack2
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "notificationBottomClose")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let contentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "알림 수신 동의는 알림 설정 메뉴에서 관리하실 수 있습니다.\n보관함 탭 > 마이페이지 > 알림 설정 메뉴"
        label.numberOfLines = 2
        label.font = .mumentB8M12
        label.textColor = .mBlack2
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "mumentNotification")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let notBeNotifiedButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setBackgroundColor(.mGray4, for: .normal)
        button.setTitleWithCustom("알림 받지 않기", font: .mumentB2B14, color: .mGray1, for: .normal)
        button.makeRounded(cornerRadius: 11)
        return button
    }()
    
    private let notifiedButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setBackgroundColor(.mPurple1, for: .normal)
        button.setTitleWithCustom("좋아요 알림 받기", font: .mumentB2B14, color: .mWhite, for: .normal)
        button.makeRounded(cornerRadius: 11)
        return button
    }()
    
    // MARK: Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setCloseButtonAction()
        self.setNotifiedButtonAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateBottomViewUI()
    }
    
    // MARK: Methods
    private func setCloseButtonAction() {
        self.closeButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
        
        self.notBeNotifiedButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func setNotifiedButtonAction() {
        self.notifiedButton.press { [weak self] in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                self?.dismiss(animated: true)
            }
        }
    }
}

// MARK: - UI

extension NotificationOnBottomVC {
    private func setUI() {
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    private func setLayout() {
        self.setBottomViewLayout()
        self.setContentLayout()
    }
    
    private func updateBottomViewUI() {
        self.bottomView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(self.bottomView.layer.cornerRadius)
        }
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.view.layoutIfNeeded()
            })
    }
    
    private func setBottomViewLayout() {
        self.view.addSubview(bottomView)
        
        self.bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(413 + self.bottomView.layer.cornerRadius)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(413 + self.bottomView.layer.cornerRadius)
        }
    }
    
    private func setContentLayout() {
        self.bottomView.addSubviews([titleLabel, closeButton, contentLabel, imageView, notBeNotifiedButton, notifiedButton])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        self.closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(14)
            make.width.height.equalTo(24)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(22)
            make.trailing.leading.equalToSuperview().inset(61)
            make.height.equalTo(161)
        }
        
        self.notBeNotifiedButton.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(22)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(162.adjustedW)
            make.height.equalTo(45)
        }
        
        self.notifiedButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(self.notBeNotifiedButton)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
