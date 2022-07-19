//
//  HeaderTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class HomeTVHeader: UIView {
    
    // MARK: - Properties
    lazy var logoButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentLogo"), for: .normal)
    }
    
    lazy var notificationButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentNoti"), for: .normal)
    }
    
    lazy var searchButton = UIButton().then{
        $0.setTitle("어떤 노래가 궁금하신가요?", for: .normal)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.titleLabel?.font = .mumentB2B14
        $0.backgroundColor = .mGray5
        $0.layer.cornerRadius = 10
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "mumentSearch")
        $0.configuration?.imagePadding = 10
        $0.contentHorizontalAlignment = .left
    }
    
    private let headerCoverView = UIView().then{
        $0.backgroundColor = .mBgwhite
    }
    
    // MARK: - Initialization
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
extension HomeTVHeader {
    
    private func setLayout() {
        self.addSubviews([logoButton,notificationButton,searchButton
//                          ,headerCoverView
                         ])
        self.backgroundColor = .mBgwhite
       
        searchButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
//            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.height.equalTo(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        logoButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
//            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
//            $0.top.equalToSuperview().offset(11)
            $0.width.equalTo(132)
            $0.height.equalTo(30)
//            $0.bottom.equalTo(searchButton.snp.top).inset(15)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(60)
        }
        
        notificationButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
//            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
//            $0.top.equalToSuperview().offset(11)
            $0.width.height.equalTo(48)
//            $0.bottom.equalTo(searchButton.snp.top).inset(15)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(55)
        }
        
//        headerCoverView.snp.makeConstraints{
//            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
//            $0.height.equalTo(48)
//            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
//        }
    }
}
