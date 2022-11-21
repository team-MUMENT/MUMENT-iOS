//
//  MembershipWithdrawalVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/21.
//

import UIKit
import SnapKit
import Then

class MembershipWithdrawalVC: BaseVC {

    // MARK: - Components
    private let naviView = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "회원탈퇴")
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "mumentProfileSad601")
    }
    
    private let headingLabel = UILabel().then {
        $0.text = "정말 떠나시는 건가요?"
        $0.font = .mumentH2B18
    }
    
    private let noticeLabel = UILabel().then {
        $0.text = "지금 당장 뮤멘트를 떠나시면 곡에 담긴 추억이 모두 사라지게 돼요. 00님이 좋아하신 뮤멘트들도 더이상 모아볼 수 없게 됩니다."
        $0.font = .mumentB3M14
        $0.numberOfLines = 3
    }
    
    private let inquiryLabel = UILabel().then {
        $0.text = "탈퇴하시려는 이유가 궁금해요."
        $0.font = .mumentB4M14
    }

    private let dropDownButton = UIButton().then {
        $0.setTitle("이유 선택", for: .normal)
    }
    
    private let checkBoxButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "mumentUnchecked"), for: .normal)
    }
    
    private let reconfirmingLabel = UILabel().then {
        $0.text = "안내사항을 모두 확인했으며, 탈퇴를 신청합니다."
        $0.font = .mumentB8M12
    }
    
    lazy var reconfirmingStackView = UIStackView(arrangedSubviews: [checkBoxButton, reconfirmingLabel]).then{
        $0.axis = .horizontal
    }
    
    private let withdrawalButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("탈퇴하기", for: .normal)
    }
    
    // MARK: - View Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setLayout()
        }
}

// MARK: - UI
extension MembershipWithdrawalVC {

    private func setLayout() {
        view.addSubviews([naviView, imageView, headingLabel, noticeLabel, inquiryLabel, dropDownButton, withdrawalButton, reconfirmingStackView])

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
        
        dropDownButton.snp.makeConstraints {
            $0.top.equalTo(inquiryLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(20)
        }

        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(39)
            $0.centerX.equalToSuperview()
        }
        
        reconfirmingStackView.snp.makeConstraints {
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
}
