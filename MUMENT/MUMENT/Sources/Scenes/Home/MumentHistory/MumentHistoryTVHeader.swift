//
//  MumentHistoryTVHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/16.
//


import UIKit
import SnapKit
import Then

class MumentHistoryTVHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
//    private let titleLabel = UILabel().then{
//        $0.text = "모든 뮤멘트"
//        $0.textColor = .mBlack2
//        $0.font = .mumentB1B15
//    }
    private let songInfoView = SongInfoView()
    private let latestOrderingButton = OrderingButton("최신순")
    private let oldestOrderingButton = OrderingButton("오래된순")
    
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
        latestOrderingButton.isSelected = true
        oldestOrderingButton.isSelected = false
        
        latestOrderingButton.press {
            self.latestOrderingButton.isSelected = true
            self.oldestOrderingButton.isSelected = false
        }
        oldestOrderingButton.press {
            self.oldestOrderingButton.isSelected = true
            self.latestOrderingButton.isSelected = false
        }
    }
}

// MARK: - UI
extension MumentHistoryTVHeader {
    
    private func setLayout() {
        self.addSubviews([songInfoView,latestOrderingButton,oldestOrderingButton])
        
        songInfoView.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        latestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(latestOrderingButton.snp.leading)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            
        }
        
        oldestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
        }
    }
}

