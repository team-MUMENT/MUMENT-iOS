//
//  AllMumentsSectionHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

protocol AllMumentsSectionHeaderDelegate : AnyObject{
    func sortingFilterButtonClicked(_ recentOnTop: Bool)
}

class AllMumentsSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    var delegate: AllMumentsSectionHeaderDelegate?
    
    private let titleLabel = UILabel().then{
        $0.text = "모든 뮤멘트"
        $0.textColor = .mBlack2
        $0.font = .mumentB1B15
    }
    
    private let mostLikedOrderingButton = OrderingButton("좋아요순")
    private let latestOrderingButton = OrderingButton("최신순")
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setSelectedButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    private func setSelectedButton() {
        mostLikedOrderingButton.isSelected = true
        latestOrderingButton.isSelected = false
        
        mostLikedOrderingButton.press {
            self.mostLikedOrderingButton.isSelected = true
            self.latestOrderingButton.isSelected = false
            self.delegate?.sortingFilterButtonClicked(true)
        }
        latestOrderingButton.press {
            self.latestOrderingButton.isSelected = true
            self.mostLikedOrderingButton.isSelected = false
            self.delegate?.sortingFilterButtonClicked(false)
        }
    }
}

// MARK: - UI
extension AllMumentsSectionHeader {
    
    private func setLayout() {
        self.addSubviews([titleLabel,mostLikedOrderingButton,latestOrderingButton])
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        mostLikedOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(latestOrderingButton.snp.leading)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            
        }
        
        latestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
        }
    }
}
