//
//  MumentCardBySongView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MumentCardBySongTVC: UITableViewCell {
    
    // MARK: - Properties
    let mumentCard = MumentCardBySongView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentCardBySongModel){
        mumentCard.setData(cellData)
    }
}

// MARK: - UI
extension MumentCardBySongTVC {
    
    func setLayout() {
        self.addSubviews([mumentCard])
        
        mumentCard.snp.makeConstraints{
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
    }
}

