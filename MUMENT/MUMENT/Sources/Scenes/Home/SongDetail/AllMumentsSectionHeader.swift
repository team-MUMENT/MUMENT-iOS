//
//  AllMumentsSectionHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class AllMumentsSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private let titleLabel = UILabel().then{
        $0.text = "모든 뮤멘트"
        $0.textColor = .mBlack2
        $0.font = .mumentB1B15
    }
    
    private let mostLikedOrderingButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.imagePlacement = .trailing
        $0.setTitle("좋아요순", for: .normal)
    }
    
    private let latestOrderingButton = UIButton().then{
        $0.configuration = .plain()
        $0.configuration?.imagePlacement = .trailing
        $0.setTitle("최신 순", for: .normal)
    }

    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setLayout()
//            configureLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setLayout()
        }
    
    //MARK: - Functions
    func setTitle(_ title:String){
        titleLabel.text = title
    }
}

// MARK: - UI
extension AllMumentsSectionHeader {
    
    private func setLayout() {
        self.addSubviews([titleLabel,mostLikedOrderingButton,latestOrderingButton])
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide)
//            $0.height.width.equalTo(48)
        }
        
        mostLikedOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(latestOrderingButton.snp.leading).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide)
            
        }
        
        latestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
