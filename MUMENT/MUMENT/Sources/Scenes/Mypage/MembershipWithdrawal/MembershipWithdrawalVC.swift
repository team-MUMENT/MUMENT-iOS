//
//  MembershipWithdrawalVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/21.
//

import UIKit
import SnapKit
import Then

final class MembershipWithdrawalVC: BaseVC {
    
    // MARK: Properties
    private var userName: String = ""{
        didSet{
            noticeLabel.text = "지금 당장 뮤멘트를 떠나시면 곡에 담긴 추억이 모두 사라지게 돼요. \(userName)님이 좋아하신 뮤멘트들도 더이상 모아볼 수 없게 됩니다."
        }
    }
    
    private var isReasonMenuHidden: Bool = false{
        didSet{
            reasonSelectingMenuView.isHidden = isReasonMenuHidden
            if isReasonMenuHidden {
                reasonSelectionButton.setBackgroundImage(UIImage(named: "dropDownButton_unselected"), for: .normal)
            }else{
                reasonSelectionButton.setBackgroundImage(UIImage(named: "dropDownButton_selected"), for: .normal)
            }
        }
    }
    
    private var isCheckBoxChecked: Bool = false{
        didSet{
            let image = isCheckBoxChecked ? UIImage(named: "mumentChecked") : UIImage(named: "mumentUnchecked")
            checkBoxButton.setBackgroundImage(image, for: .normal)
        }
    }
    
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
        $0.text = "지금 당장 뮤멘트를 떠나시면 곡에 담긴 추억이 모두 사라지게 돼요. 사용자 님이 좋아하신 뮤멘트들도 더이상 모아볼 수 없게 됩니다."
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
    
    private let reasonSelectingMenuView: DropDownMenuView = DropDownMenuView()
    
    private let checkBoxButton: UIButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "mumentUnchecked"), for: .normal)
    }
    
    private let confirmingLabel: UILabel = UILabel().then {
        $0.text = "안내사항을 모두 확인했으며, 탈퇴를 신청합니다."
        $0.font = .mumentB8M12
    }
    
    private lazy var confirmingStackView: UIStackView = UIStackView(arrangedSubviews: [checkBoxButton, confirmingLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    private let withdrawalButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("탈퇴하기", for: .normal)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        reasonSelectingMenuView.setDelegate(delegate: self)
    }
    
    func setButtonActions(){
        reasonSelectionButton.press{
            self.isReasonMenuHidden.toggle()
        }
        
        checkBoxButton.press{
            self.isCheckBoxChecked.toggle()
        }
    }
}

// MARK: - UI
extension MembershipWithdrawalVC {
    
    private func setLayout() {
        view.addSubviews([naviView, imageView, headingLabel, noticeLabel, inquiryLabel, reasonSelectionButton, reasonSelectingMenuView, withdrawalButton, confirmingStackView])
        
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
        
        reasonSelectingMenuView.snp.makeConstraints{
            $0.top.equalTo(reasonSelectionButton.snp.bottom)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(500)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(39)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(47)
        }
        
        confirmingStackView.snp.makeConstraints {
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MembershipWithdrawalVC: DropDownMenuViewDelegate {
    func handleTVCSelectedEvent(_ menuLabel: String) {
        self.isReasonMenuHidden.toggle()
        reasonSelectionButton.setTitleLabel(menuLabel)
    }
}
