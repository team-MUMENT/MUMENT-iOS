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
        $0.setLabel(text: "test", font: UIFont.mumentB4M14)
    }
    
    var tagCount: String = "" {
        didSet{
            let highlitedString = NSAttributedString(string: tagCount, attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mBlue1
            ])
            
            let normalString = NSAttributedString(string: " / 3", attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mGray1
            ])
            
            let title = highlitedString + normalString
            selectedTagsCountLabel.attributedText = title
        }
    }
    
    // MARK: - Tag View
    private let impressionLabel = UILabel().then {
        $0.text = "인상적인 부분"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let feelLabel = UILabel().then {
        $0.text = "감정"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    
    var clickedTag: [Int] = []
    
    var impressionTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브"]
    var feelTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브", "🎡 벅참", "😄 신남", " 💐 설렘", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스"]
    
//    private let stackViewArray = [UIStackView]
    
    private let tagButton1 = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "🛫 도입부"
        config.titleAlignment = .center
        config.baseForegroundColor = UIColor.mGray1
        config.baseBackgroundColor = UIColor.red
        config.cornerStyle = .capsule
        $0.configuration = config
        
        $0.makeRounded(cornerRadius: 19)
        $0.titleLabel?.font = UIFont.mumentB4M14
    }
    
    private let tagButton2 = UIButton().then {
        $0.configuration = UIButton.Configuration.plain()
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 13.0, bottom: 8.0, trailing: 13.0)
        $0.backgroundColor = .mGray5
        $0.makeRounded(cornerRadius: 19)
        $0.titleLabel?.font = UIFont.mumentB4M14
        $0.setTitle("🛫 도입부", for: .normal)
        $0.setTitleColor(UIColor.mGray1, for: .normal)
        $0.contentHorizontalAlignment = .center
    }
    
    private let tagButton3 = UIButton().then {
        $0.configuration = UIButton.Configuration.plain()
        $0.backgroundColor = .mGray5
        $0.makeRounded(cornerRadius: 19)
        $0.titleLabel?.font = UIFont.mumentB4M14
        $0.setTitle("🛫 도입부", for: .normal)
        $0.setTitleColor(UIColor.mGray1, for: .normal)
        $0.contentHorizontalAlignment = .center
    }
//    private let contentLabel = UILabel().then {
//        $0.textAlignment = .center
//        $0.font = .mumentB4M14
//        $0.textColor = .mGray1
//    }
    
    private let imPressionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let imPressionTagRowStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let feelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let feelTagRowStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviUI()
        setDismissButtonAction()
        tagCount = "1"
        
        setStackViewLayout()
    }
    
    /// 바텀시트 밖 터치했을때 dismiss (필요시 사용)
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        if let touch = touches.first,
//           touch.view == self.view {
//            hideBottomSheetWithAnimation()
//        }
//    }

    private func setDismissButtonAction() {
        dismissButton.press {
            self.isDismissed = true
            self.hideBottomSheetWithAnimation()
        }
    }
}

// MARK: - UI
extension StorageBottomSheet {
    private func setNaviUI() {
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
}

// MARK: - BottomSheet Animation
extension StorageBottomSheet {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
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

// MARK: - BottomSheetTagView
extension StorageBottomSheet {
    func setStackViewLayout() {
        containerView.addSubviews([impressionLabel, imPressionStackView])
        
        [imPressionTagRowStackView, imPressionTagRowStackView, imPressionTagRowStackView].forEach {
            self.imPressionStackView.addArrangedSubview($0)
        }
        
        [tagButton1, tagButton2, tagButton3].forEach {
            self.imPressionTagRowStackView.addArrangedSubview($0)
        }
        
        impressionLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(45)
            $0.left.equalToSuperview().inset(22)
            $0.height.equalTo(16)
        }
        
        imPressionStackView.snp.makeConstraints {
            $0.top.equalTo(impressionLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(37.adjustedH)
        }
    }
}
