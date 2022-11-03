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
}

// MARK: - UI
extension DefaultNavigationBar {
    
    private func setLeftArrowLayout() {
        self.addSubviews([backButton, titleLabel])
        
        backButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func setLeftArrowRightDoneLayout() {
        self.addSubviews([backButton, titleLabel, doneButton])
        
        backButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(50)
        }
    }
    
    private func setLeftCloseRightDone() {
        self.addSubviews([closeButton, titleLabel, doneButton])
        
        closeButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(50)
        }
    }
    
    /// 커스텀 네비 바 타이틀 설정하는 메서드
    func setTitleLabel(title: String) {
        self.titleLabel.text = title
    }
}
