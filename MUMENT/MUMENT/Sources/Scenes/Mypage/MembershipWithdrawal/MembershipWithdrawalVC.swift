//
//  MembershipWithdrawalVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/21.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MembershipWithdrawalVC: BaseVC {
    
    // MARK: - Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "회원탈퇴")
    }
    
    private let imageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "mumentProfileSad601")
    }
    
    private let headingLabel: UILabel = UILabel().then {
        $0.text = "정말 떠나시는 건가요?"
        $0.font = .mumentH2B18
        $0.textColor = .mBlack1
    }
    
    private let noticeLabel: UILabel = UILabel().then {
        $0.text = "지금 당장 뮤멘트를 떠나시면 곡에 담긴 추억이 모두 사라지게 돼요. 사용자 님이 좋아하신 뮤멘트들도 더 이상 모아볼 수 없게 됩니다."
        $0.font = .mumentB3M14
        $0.textColor = .mBlack2
        $0.numberOfLines = 3
        $0.lineBreakMode = .byCharWrapping
    }
    
    private let inquiryLabel: UILabel = UILabel().then {
        $0.text = "탈퇴하시려는 이유가 궁금해요."
        $0.font = .mumentB4M14
        $0.textColor = .mBlack1
    }
    
    private let reasonSelectionButton: DropDownButton = DropDownButton(title: "이유 선택")
    
    private let reasonSelectingMenuView: DropDownMenuView = DropDownMenuView().then {
        $0.isHidden = true
        $0.makeRounded(cornerRadius: 11)
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private let reasonTextView: UITextView = UITextView().then {
        $0.isHidden = true
        $0.isScrollEnabled = false
        $0.clipsToBounds = true
        $0.makeRounded(cornerRadius: 7)
        $0.backgroundColor = .mGray5
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 13, bottom: 15, right: 13)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        $0.font = .mumentB3M14
        $0.autocapitalizationType = .none
        $0.textColor = .mBlack2
    }
    
    private let reasonTextViewLabel: UILabel = UILabel().then {
        $0.isHidden = true
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.text = "0/100"
        $0.setColor(to: "0", with: .mPurple1)
    }
    
    private let checkBoxButton: UIButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "mumentUnchecked"), for: .normal)
    }
    
    private let confirmingLabel: UILabel = UILabel().then {
        $0.text = "안내사항을 모두 확인했으며, 탈퇴를 신청합니다."
        $0.font = .mumentB8M12
    }
    
    private lazy var confirmingStackView: UIStackView = UIStackView(arrangedSubviews: [checkBoxButton, confirmingLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    private let withdrawalButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("탈퇴하기", for: .normal)
    }
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var userName: String = "" {
        didSet {
            noticeLabel.text = "지금 당장 뮤멘트를 떠나시면 곡에 담긴 추억이 모두 사라지게 돼요. \(userName)님이 좋아하신 뮤멘트들도 더 이상 모아볼 수 없게 됩니다."
        }
    }
    
    private var isReasonMenuHidden: Bool = true {
        didSet {
            reasonSelectingMenuView.isHidden = isReasonMenuHidden
            if isReasonMenuHidden {
                reasonSelectionButton.setBackgroundImage(UIImage(named: "dropDownButton_unselected"), for: .normal)
            } else {
                reasonSelectionButton.setBackgroundImage(UIImage(named: "dropDownButton_selected"), for: .normal)
            }
        }
    }
    
    private var isTextViewHidden: Bool = true {
        didSet {
            reasonTextView.isHidden = isTextViewHidden
            reasonTextViewLabel.isHidden = isTextViewHidden
        }
    }
    
    private var isCheckBoxChecked: Bool = false {
        didSet {
            let image = isCheckBoxChecked ? UIImage(named: "mumentChecked") : UIImage(named: "mumentUnchecked")
            checkBoxButton.setBackgroundImage(image, for: .normal)
            if isCheckBoxChecked && (reasonSelectionButton.getTitleLabel() != "이유 선택") {
                withdrawalButton.isEnabled = true
            } else {
                withdrawalButton.isEnabled = false
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        setReasonTextView()
        setReasonTextCounting()
        reasonSelectingMenuView.setDelegate(delegate: self)
        hideTabbar()
        
    }
    
    // MARK: - Functions
    private func setButtonActions() {
        
        self.naviView.setBackButtonAction {
            self.navigationController?.popViewController(animated: true)
        }
        
        reasonSelectionButton.addTarget(self, action: #selector(self.reasonSelectionButtonClicked(_:)), for: .touchUpInside)
        
        checkBoxButton.press {
            self.isCheckBoxChecked.toggle()
        }
        
        withdrawalButton.press {
            let leaveCategoryNum = self.reasonSelectingMenuView.getSelectedMenuNumber()
            var reasonEtc = ""
            if (leaveCategoryNum == 7) {
                reasonEtc = self.reasonTextView.text
            }
            self.requestPostWithdrawalReason(data: WithdrawalReasonBodyModel(leaveCategoryId: leaveCategoryNum, reasonEtc: reasonEtc))
        }
    }
    
    @objc private func reasonSelectionButtonClicked(_ sender:Any?) -> Void {
        self.isReasonMenuHidden.toggle()
        if !isTextViewHidden { isTextViewHidden.toggle() }
        self.view.frame.origin.y = 0
        self.dismissKeyboard()
    }
    
    private func setReasonTextView() {
        reasonTextView.delegate = self
        reasonTextView.text = "계정을 삭제하는 이유를 알려주세요."
        reasonTextView.textColor = .mGray1
    }
    
    private func setReasonTextCounting() {
        reasonTextView.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                if self.reasonTextView.textColor == .mBlack2 {
                    DispatchQueue.main.async {
                        self.reasonTextViewLabel.text = "\(changedText.count)/100"
                        self.reasonTextViewLabel.setColor(to: "\(changedText.count)", with: .mPurple1)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setUserName(_ userName: String) {
        self.userName = userName
    }
}

// MARK: - UI
extension MembershipWithdrawalVC {
    
    private func setLayout() {
        view.addSubviews([naviView, imageView, headingLabel, noticeLabel, inquiryLabel,  reasonSelectingMenuView, reasonSelectionButton, reasonTextView, reasonTextViewLabel, withdrawalButton, confirmingStackView])
        
        naviView.snp.makeConstraints {
            $0.left.top.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        headingLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        inquiryLabel.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        
        reasonSelectionButton.snp.makeConstraints {
            $0.top.equalTo(inquiryLabel.snp.bottom).offset(13)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        reasonTextView.snp.makeConstraints {
            $0.top.equalTo(reasonSelectionButton.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(134)
        }
        
        reasonTextViewLabel.snp.makeConstraints {
            $0.bottom.equalTo(reasonTextView).offset(-15)
            $0.right.equalTo(reasonTextView).inset(11)
        }
        
        reasonSelectingMenuView.snp.makeConstraints {
            $0.top.equalTo(reasonSelectionButton.snp.bottom).inset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(39)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(47)
        }
        
        confirmingStackView.snp.makeConstraints {
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(-15)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - DropDownMenuViewDelegate
extension MembershipWithdrawalVC: DropDownMenuViewDelegate {
    func handleTVCSelectedEvent(_ menuLabel: String) {
        self.isReasonMenuHidden.toggle()
        reasonSelectionButton.setTitleLabel(menuLabel)
        withdrawalButton.isEnabled = isCheckBoxChecked
        if menuLabel == "기타" {
            isTextViewHidden = false
        }
    }
}

// MARK: - UITextViewDelegate
extension MembershipWithdrawalVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reasonTextView.textColor == UIColor.mGray1 {
            reasonTextView.text = ""
            reasonTextView.textColor = .mBlack2
        }
        
        self.view.frame.origin.y = -280
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reasonTextView.text.isEmpty {
            reasonTextView.text =  "계정을 삭제하는 이유를 알려주세요."
            reasonTextView.textColor = .mGray1
        }
        
        self.view.frame.origin.y = 0
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = reasonTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 100
    }
}

// MARK: - Network
extension MembershipWithdrawalVC {
    private func requestPostWithdrawalReason(data: WithdrawalReasonBodyModel) {
        MyPageAPI.shared.postWithdrawalReason(body: data) { networkResult in
            switch networkResult {
            case .success:
                self.requestPostWithdrawalReason()
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestPostWithdrawalReason() {
        MyPageAPI.shared.deleteMembership() { networkResult in
            switch networkResult {
            case .success:
                self.removeUserInfo()
                let onboardingVC = OnboardingVC()
                onboardingVC.modalPresentationStyle = .fullScreen
                onboardingVC.modalTransitionStyle = .crossDissolve
                self.present(onboardingVC, animated: true)
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
