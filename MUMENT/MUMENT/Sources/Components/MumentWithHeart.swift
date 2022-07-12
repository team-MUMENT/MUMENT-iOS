//
//  MumentWithHeart.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/13.
//

import UIKit
import SnapKit
import Then

class MumentWithHeart: DefaultMumentView {
    
    // MARK: - Properties
    private let heartButton = UIButton().then{
        $0.setTitleColor(.mGray1, for: .normal)
        $0.titleLabel?.font = .mumentC1R12
        $0.configuration = .plain()
        $0.configuration?.imagePadding = 10
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentForTodayModel){
        heartButton.configuration?.image = UIImage(named: "mumentSearch")
        heartButton.setTitle("뮤멘트를 둘러보세요.", for: .normal)
    }
    
    
}

// MARK: - UI
extension MumentWithHeart {
    override func setLayout() {
        self.addSubviews([heartButton])
        
        heartButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
    }
}

