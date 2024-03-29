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
    lazy var titleLabel = UILabel().then{
        $0.text = "오늘의 뮤멘트"
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }
    let mumentCardView = MumentForTodayCardView()
    
    // Test Code
    var dataSource: [MumentCardWithoutHeartModel] = MumentCardWithoutHeartModel.sampleData
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        fetchData()
        setLayout()
        self.backgroundColor = .mBgwhite
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
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        mumentCardView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension MumentForTodayTVC {
    
    func setData(_ cellData: MumentForTodayResponseModel) {
        mumentCardView.setMumentForTodayData(cellData)
    }
}
