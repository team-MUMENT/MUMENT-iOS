//
//  DefaultSongHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class DefaultSongDetailHeader: UIView {
    
    // MARK: - Properties
    private let backbutton = UIButton().then{
        $0.setImage(UIImage(named: "backIcon"), for: .normal)
        $0.configuration = .plain()
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
    }
}

// MARK: - UI
extension DefaultSongDetailHeader {
    
    private func setLayout() {
        self.addSubviews([backbutton])
        
        backbutton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.height.width.equalTo(48)
            
        }
    }
}
