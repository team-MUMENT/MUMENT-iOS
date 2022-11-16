//
//  MumentTextField.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/14.
//

import UIKit
import RxCocoa
import RxSwift

/**
 - Description:
 뮤멘트에서 자주 사용되는 텍스트필드
 */
final class MumentTextField: UITextField {
    
    // MARK: Components
    let clearButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentDelete2"), for: .normal)
    }
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setDefaultStyle()
        self.setTextFieldClearBtn(textField: self, clearBtn: self.clearButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setDefaultStyle()
        self.setTextFieldClearBtn(textField: self, clearBtn: self.clearButton)
    }
    
    // MARK: Functions
    /// textField-btn 에 clear 기능 세팅하는 함수
    private func setTextFieldClearBtn(textField: UITextField, clearBtn: UIButton) {
        textField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                clearBtn.isHidden = changedText != "" ? false : true
            })
            .disposed(by: disposeBag)
        
        /// Clear 버튼 액션
        clearButton.rx.tap
            .bind {
                textField.text = ""
                clearBtn.isHidden = true
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UI
extension MumentTextField {
    private func setDefaultStyle() {
        self.addSubviews([clearButton])
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(clearButton.snp.height)
        }
        
        self.backgroundColor = .mGray4
        self.makeRounded(cornerRadius: 11)
        self.addLeftPadding(17)
        self.addRightPadding(34)
        self.font = .mumentH4M16
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.mGray1])
        self.textColor = .mBlack2
    }
}
