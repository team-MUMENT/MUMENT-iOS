//
//  DefaultSongHeader.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class DefaultNavigationBar: UIView {
    
    // MARK: - Properties
    private let backbutton = UIButton().then{
        $0.setImage(UIImage(named: "backIcon"), for: .normal)
        $0.configuration = .plain()
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setDefaultLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setDefaultLayout()
    }
    
    //MARK: - Functions
    func setTitle(_ title:String){
        titleLabel.text = title
    }
}

// MARK: - UI
extension DefaultNavigationBar {
    
    private func setDefaultLayout() {
        self.addSubviews([backbutton,titleLabel])
        
        backbutton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
