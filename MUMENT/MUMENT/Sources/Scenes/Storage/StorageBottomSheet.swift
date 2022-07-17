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
        $0.backgroundColor = UIColor.mPurple1
    }
    
    private let containerHeight = NSLayoutConstraint()
    private let itemStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    /// 바텀시트 밖 터치했을때 dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            hideBottomSheetWithAnimation()
        }
    }

    private func setupUI() {
        /// 백그라운드 그레이로 수정
        self.view.backgroundColor = UIColor.mBlue1
        
        view.addSubViews([self.containerView])
        
        containerHeight.constant = 0
        
        self.containerView.snp.makeConstraints{
            $0.height.equalTo(containerHeight.constant)
            $0.width.equalTo(view.frame.width)
            $0.left.right.bottom.equalToSuperview()
        }
        containerView.layer.cornerRadius = 11
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func cancelButtonTapped() {
        hideBottomSheetWithAnimation()
    }
}

// MARK: - Show/Hide Animation
extension StorageBottomSheet {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 699.adjustedH
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
        }
        
    }
    
    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 0
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
