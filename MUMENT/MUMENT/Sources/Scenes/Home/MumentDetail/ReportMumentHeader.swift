//
//  ReportMumentHeader.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

final class ReportMumentHeader: UITableViewHeaderFooterView {
    
    private let reportTitleLabel = UILabel().then {
        $0.font = .mumentH3B16
        $0.textColor = .mBlack1
        $0.text = "뮤멘트를 신고하는 이유를 알려주세요!"
    }
    
    private let reportSubTitleLabel = UILabel().then {
        $0.font = .mumentB6M13
        $0.textColor = .mGray1
        $0.text = "관리자 검토 후 타당한 근거 없이 신고된 내용은 \n반영되지 않을 수 있습니다."
        $0.numberOfLines = 0
    }
    
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setLayout() {
        self.addSubviews([reportTitleLabel, reportSubTitleLabel])
        
        reportTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.equalToSuperview().inset(27)
            $0.height.equalTo(22)
        }
        
        reportSubTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(reportTitleLabel.snp.leading)
            $0.top.equalTo(reportTitleLabel.snp.bottom).offset(8)
            $0.height.equalTo(38)
        }
    }
}
