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
//        $0.setTitle("좋아요순", for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "좋아요순", attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mPurple1
        ]), for: .normal)
        $0.configuration?.buttonSize = .small

    }
    
    private let latestOrderingButton = UIButton().then{
        $0.isEnabled = false
        $0.configuration = .plain()
        $0.configuration?.imagePlacement = .trailing
        $0.setTitle("최신 순", for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "최신순", attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mPurple1
        ]), for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "최신순", attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mGray1
        ]), for: .disabled)
        $0.configuration?.buttonSize = .small
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
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
//            $0.height.width.equalTo(48)
        }
        
        mostLikedOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(latestOrderingButton.snp.leading)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            
        }
        
        latestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
        }
    }
}
