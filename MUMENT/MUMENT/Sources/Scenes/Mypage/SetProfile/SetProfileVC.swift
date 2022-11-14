//
//  SetProfileVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/14.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

final class SetProfileVC: BaseVC {
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrowRightDone).then {
        $0.setTitleLabel(title: "프로필 설정")
        $0.doneButton.isEnabled = false
    }
    private let loadImageButton: UIButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentProfileCamera"), for: .normal)
    }
    private let nickNameTextField: MumentTextField = MumentTextField().then {
        $0.placeholder = "닉네임을 입력해주세요. (필수)"
    }
    private let infoLabel: UILabel = UILabel().then {
        $0.text = "특수문자 제외 2-15자"
        $0.font = .mumentB8M12
        $0.textColor = .mGray2
        $0.sizeToFit()
    }
    private let nickNameCountLabel: UILabel = UILabel().then {
        $0.text = "0/15"
        $0.textColor = .mGray1
        $0.setColor(to: "0", with: .mPurple1)
        $0.font = .mumentB8M12
        $0.sizeToFit()
    }
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setClearButtonTapAction()
        self.checkNickNameIsValid()
        self.setNickNameCountLabel()
    }
    
    private func setClearButtonTapAction() {
        nickNameTextField.clearButton.press { [weak self] in
            self?.naviView.doneButton.isEnabled = false
        }
    }
    
    private func checkNickNameIsValid() {
        nickNameTextField.rx.text
            .orEmpty
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                if changedText.count > 0 {
                    let regex = "[가-힣ㄱ-ㅎㅏ-ㅣA-Za-z0-9\\s]{0,}"
                    if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: changedText) && changedText.trimmingCharacters(in: .whitespaces).count >= 2 {
                        self.naviView.doneButton.isEnabled = true
                        self.infoLabel.textColor = .mGray2
                    } else {
                        self.naviView.doneButton.isEnabled = false
                        self.infoLabel.textColor = .mRed
                    }
                } else {
                    self.naviView.doneButton.isEnabled = false
                    self.infoLabel.textColor = .mGray2
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setNickNameCountLabel() {
        nickNameTextField.rx.text
            .orEmpty
            .skip(1)
            .subscribe(onNext: { changedText in
                DispatchQueue.main.async {
                    let countString = "\(changedText.count)"
                    self.nickNameCountLabel.text = countString + "/15"
                    self.nickNameCountLabel.setColor(to: countString, with: .mPurple1)
                }
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UI
extension SetProfileVC {
    private func setLayout() {
        self.view.addSubviews([naviView, loadImageButton, nickNameTextField, infoLabel, nickNameCountLabel])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        loadImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(131)
            $0.top.equalTo(naviView.snp.bottom).offset(79)
        }
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(loadImageButton.snp.bottom).offset(64)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            $0.left.equalTo(nickNameTextField)
        }
        nickNameCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel)
            $0.right.equalTo(nickNameTextField)
        }
    }
}
