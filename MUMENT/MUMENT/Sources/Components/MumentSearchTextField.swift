//
//  MumentSearchTextField.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MumentSearchTextField: UITextField {
    
    enum Text: String {
        case placeholder = "곡, 아티스트"
    }
    
    // MARK: Components
    private let leadingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    private let searchImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "mumentSearch")?.withRenderingMode(.alwaysOriginal))
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        return imageView
    }()
    
    let clearButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(named: "mumentDelete2")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: Properties
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setLayout()
        self.setClearButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func setClearButton() {
        self.clearButton.rx.tap
            .bind {
                self.text = ""
                self.clearButton.isHidden = true
            }
            .disposed(by: self.disposeBag)
        
        self.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                self.clearButton.isHidden = changedText != "" ? false : true
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UI
extension MumentSearchTextField {
    private func setUI() {
        self.backgroundColor = .mGray5
        self.makeRounded(cornerRadius: 11.adjustedH)
        self.placeholder = "곡, 아티스트"
        self.font = .mumentB4M14
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.mBgwhite.cgColor
        self.leftViewMode = .always
        self.tintColor = .mPurple1
        self.returnKeyType = .search
        self.addRightPadding(37)
    }
    
    private func setLayout() {
        self.leadingView.addSubview(searchImageView)
        self.leftView = self.leadingView
        self.addSubview(clearButton)
        
        self.clearButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(8)
            make.width.equalTo(24)
        }
    }
}
