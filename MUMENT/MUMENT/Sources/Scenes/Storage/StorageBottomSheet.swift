//
//  StorageBottomSheet.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/18.
//

import UIKit
import SnapKit
import Then

class StorageBottomSheet: UIViewController {

    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.mBgwhite
    }
    private let containerHeight = NSLayoutConstraint()
    let dismissButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentDelete"), for: .normal)
    }
    private let bottomSheetTitle = UILabel().then {
        $0.setLabel(text: "필터", font: UIFont.mumentH2B18)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = UIColor.mGray3
    }
    
    var isDismissed = true
    
    private let selectedTagsCount = 1
    private let selectedTagsCountLabel = UILabel().then {
        $0.setLabel(text: "1 / 3", font: UIFont.mumentB4M14)
    }
    
    private let itemStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDismissButtonAction()
    }
    /// 바텀시트 밖 터치했을때 dismiss (필요시 사용)
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        if let touch = touches.first,
//           touch.view == self.view {
//            hideBottomSheetWithAnimation()
//        }
//    }

    private func setUI() {
        /// 백그라운드 그레이로 수정
        self.view.backgroundColor = UIColor.mBlue1
        
        view.addSubViews([containerView])
        
        containerHeight.constant = 0
        
        containerView.snp.makeConstraints{
            $0.height.equalTo(containerHeight.constant)
            $0.width.equalTo(view.frame.width)
            $0.left.right.bottom.equalToSuperview()
        }
        containerView.layer.cornerRadius = 11
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        containerView.addSubViews([dismissButton, bottomSheetTitle, underLineView, selectedTagsCountLabel])
        
        dismissButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(21)
            $0.height.equalTo(25)
        }
        
        bottomSheetTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetTitle.snp.bottom).offset(20)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        selectedTagsCountLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
        }
        
        
        
    }
    
    private func setDismissButtonAction() {
        dismissButton.press {
            self.isDismissed = true
            self.hideBottomSheetWithAnimation()
        }
    }
}

// MARK: - Show/Hide Animation
extension StorageBottomSheet {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.4) {
            self.containerHeight.constant = 699.adjustedH
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 0
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
