//
//  MumentForTodayTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class MumentForTodayTVC: UITableViewCell {
    
    // MARK: - Properties
    var dataSource: [MumentWithHeartModel] = MumentWithHeartModel.sampleData
    lazy var titleLabel = UILabel().then{
        $0.text = "오늘의 뮤멘트"
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }
    
    private let mumentCardView = MumentWithHeartView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fetchData()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension MumentForTodayTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel, mumentCardView])
        selectionStyle = .none
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        mumentCardView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension MumentForTodayTVC {
    
    private func fetchData() {
        mumentCardView.setData(dataSource[0])
    }
}
