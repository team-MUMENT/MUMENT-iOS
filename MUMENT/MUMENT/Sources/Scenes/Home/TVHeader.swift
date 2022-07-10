//
//  HeaderTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class TVHeader: UIView {
    
    lazy var logoButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentLogo"), for: .normal)
    }
    
    lazy var notificationButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentNoti"), for: .normal)
    }
    
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
extension TVHeader {
    
    private func setLayout() {
        self.addSubviews([logoButton,notificationButton])
        logoButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.width.equalTo(132)
            $0.height.equalTo(30)
        }
        
        notificationButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.width.height.equalTo(23)
        }
    }
}
