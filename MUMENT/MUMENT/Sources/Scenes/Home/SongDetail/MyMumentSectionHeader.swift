//
//  MyMumentSectionHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MyMumentSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private let titleLabel = UILabel().then{
        $0.text = "내가 기록한 뮤멘트"
        $0.textColor = .mBlack2
        $0.font = .mumentB1B15
    }
    
    private let historyButton = UIButton().then{
        $0.setImage(UIImage(named: "leftArrow"), for: .normal)
        $0.configuration = .plain()
        $0.configuration?.imagePlacement = .trailing
        $0.setTitle("나의 히스토리 보기", for: .normal)
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
    
//    //MARK: - Functions
//    func setTitle(_ title:String){
//        titleLabel.text = title
//    }
}

// MARK: - UI
extension MyMumentSectionHeader {
    
    private func setLayout() {
        contentView.addSubviews([titleLabel,historyButton])
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide)
//            $0.height.width.equalTo(48)
        }
        
        historyButton.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
//            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
