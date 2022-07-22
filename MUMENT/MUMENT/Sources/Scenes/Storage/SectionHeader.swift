//
//  HeaderCRV.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/16.
//

import UIKit
import Then
import SnapKit

class SectionHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    // 날짜표시 위한 임시 변수
//    private let year = 2022
//    private let month = 7
    
    private let headerTitle = UILabel().then {
        $0.backgroundColor = .clear
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setHeader()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SectionHeader {
    func setHeader(_ year:Int, _ month:Int) {
        self.addSubViews([headerTitle])
        headerTitle.setLabel(text: "\(year)년 \(month)월", font: UIFont.mumentH3B16)
        headerTitle.textColor = UIColor.mBlack2
        
        headerTitle.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.right.top.bottom.equalToSuperview()
        }
        
    }
    
}
