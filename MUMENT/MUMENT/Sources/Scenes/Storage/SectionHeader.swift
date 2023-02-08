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
            $0.right.bottom.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-15.adjustedH)
        }
    }
    
    func resetHeader() {
        self.removeFromSuperview()
    }
}
