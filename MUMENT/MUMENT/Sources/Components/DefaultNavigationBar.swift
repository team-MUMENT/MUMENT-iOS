//
//  DefaultSongHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

enum DefaultNavigationBarType {
    
    /// leftArrow: 좌측 back 버튼 + 타이틀
    case leftArrow
    
    /// leftArrowRightDone: 좌측 back 버튼 + 타이틀 + 우측 완료 버튼
    case leftArrowRightDone
    
    /// leftCloseRightDone: 좌측 Close 버튼 + 타이틀 + 우측 완료 버튼
    
    case leftCloseRightDone
    
    /// leftArrowRightSetting: 좌측 back 버튼 + 타이틀 + 우측 설정 버튼
    
    case leftArrowRightSetting
}

class DefaultNavigationBar: UIView {
    
    // MARK: - Properties
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "leftArrow"), for: .normal)
        $0.configuration = .plain()
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let closeButton: UIButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentDelete3"), for: .normal)
    }
    
    let doneButton: UIButton = UIButton(type: .system).then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.mGray2, for: .disabled)
        $0.setTitleColor(.mPurple1, for: .normal)
        $0.titleLabel?.font = .mumentH2B18
    }
    
    let settingButton: UIButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "setttingIcon"), for: .normal)
    }
    
    var type: DefaultNavigationBarType = .leftArrow
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLeftArrowLayout()
    }
    
    init(naviType: DefaultNavigationBarType = .leftArrow) {
        super.init(frame: .zero)
        switch naviType {
        case .leftArrow:
            setLeftArrowLayout()
        case .leftArrowRightDone:
            setLeftArrowRightDoneLayout()
        case .leftCloseRightDone:
            setLeftCloseRightDone()
        case .leftArrowRightSetting:
            setLeftArrowRightSettingLayout()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLeftArrowLayout()
    }
    
    //MARK: - Functions
    func setTitle(_ title:String){
        titleLabel.text = title
    }
    
    func setBackButtonAction(_ closure: @escaping () -> Void) {
        self.backButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
    
    func setSettingButtonAction(_ closure: @escaping () -> Void) {
        self.settingButton.addAction( UIAction { _ in closure() }, for: .touchUpInside)
    }
}

// MARK: - UI
extension DefaultNavigationBar {
    
    private func setLeftArrowLayout() {
        self.addSubviews([backButton, titleLabel])
        self.setBackButtonLayout()
        self.setTitleLabelLayout()
    }
    
    private func setLeftArrowRightDoneLayout() {
        self.addSubviews([backButton, titleLabel, doneButton])
        self.setBackButtonLayout()
        self.setTitleLabelLayout()
        self.setDoneButtonLayout()
    }
    
    private func setLeftArrowRightSettingLayout() {
        self.addSubviews([backButton, titleLabel, settingButton])
        self.setBackButtonLayout()
        self.setTitleLabelLayout()
        self.setSettingButtonLayout()
    }
    
    private func setLeftCloseRightDone() {
        self.addSubviews([closeButton, titleLabel, doneButton])
        
        closeButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
        
        self.setTitleLabelLayout()
        self.setDoneButtonLayout()
    }
    
    private func setBackButtonLayout() {
        backButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
    }
    
    private func setTitleLabelLayout() {
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(55)
        }
    }
    
    private func setDoneButtonLayout() {
        doneButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(50)
        }
    }
    
    private func setSettingButtonLayout() {
        settingButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(14)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(18)
            $0.width.equalTo(self.settingButton.snp.height)
        }
    }
    
    /// 커스텀 네비 바 타이틀 설정하는 메서드
    func setTitleLabel(title: String) {
        self.titleLabel.text = title
    }
}
