//
//  AllMumentsSectionHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class OrderingButton: UIButton {
    private var buttonText = ""
    private func setConfiguration(){
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .small
        configuration.baseBackgroundColor = UIColor.mBgwhite
        self.configuration = configuration
    }
    
    private func setTextStyle(){
        self.setAttributedTitle(NSAttributedString(string: buttonText, attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mPurple1
        ]), for: .selected)
        self.setAttributedTitle(NSAttributedString(string: buttonText, attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mGray1
        ]), for: .normal)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init(_ text:String) {
        super.init(frame:CGRect.zero)
        buttonText = text
        setConfiguration()
        setTextStyle()
    }
}

class AllMumentsSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
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
        setLayout()
    }
    
    // MARK: - Functions
    private func setSelectedButton() {
        mostLikedOrderingButton.isSelected = true
        latestOrderingButton.isSelected = false
        
        mostLikedOrderingButton.press {
            self.mostLikedOrderingButton.isSelected = true
            self.latestOrderingButton.isSelected = false
        }
        latestOrderingButton.press {
            self.latestOrderingButton.isSelected = true
            self.mostLikedOrderingButton.isSelected = false
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
