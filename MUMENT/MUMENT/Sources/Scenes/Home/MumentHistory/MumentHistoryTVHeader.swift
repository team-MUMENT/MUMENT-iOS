//
//  MumentHistoryTVHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/16.
//


import UIKit
import SnapKit
import Then

protocol MumentHistoryTVHeaderDelegate : AnyObject{
    func sortingFilterButtonClicked(_ recentOnTop: Bool)
}

class MumentHistoryTVHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    var delegate: MumentHistoryTVHeaderDelegate?
    
    let songInfoView = DetailSongInfoView()
//        .then{
//        $0.clipsToBounds = true
//    }
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
            self.delegate?.sortingFilterButtonClicked(true)
        }
        oldestOrderingButton.press {
            self.oldestOrderingButton.isSelected = true
            self.latestOrderingButton.isSelected = false
            self.delegate?.sortingFilterButtonClicked(false)
        }
    }
    
    func setData(_ cellData: MusicDTO){
        songInfoView.setData(cellData)
    }
}

// MARK: - UI
extension MumentHistoryTVHeader {
    
    private func setLayout() {
        self.addSubviews([songInfoView,latestOrderingButton,oldestOrderingButton])
        
        songInfoView.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(72)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        latestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(oldestOrderingButton.snp.leading)
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.width.equalTo(42)
        }
        
        oldestOrderingButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.top.equalTo(songInfoView.snp.bottom).offset(13)
            $0.width.equalTo(52)
        }
    }
}

