//
//  MumentDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MumentDetailVC: BaseVC {
   
    // MARK: - Properties
    private let navigationBarView = DefaultNavigationBar()
    private let mumentCardView = DetailMumentCardView()
    private let historyButton = UIButton().then{
        $0.makeRounded(cornerRadius: 11)
        $0.backgroundColor = .mGray4
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "rightArrow")
        $0.layer.cornerRadius = 10
    }

    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.mumentC1R12,
        .foregroundColor: UIColor.mGray1
    ]
    
    var historyButtonText: String = "" {
        didSet{
            historyButton.setAttributedTitle(NSAttributedString(string: historyButtonText,attributes: attributes), for: .normal)
        }
    }
    
    var dataSource: [MumentDetailVCModel] = MumentDetailVCModel.sampleData
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setData()
        
    }
    
    // MARK: - Functions
    
    func setData(){
//        songInfoView.setData(songInfoDataSource[0])
        navigationBarView.setTitle("뮤멘트")
        mumentCardView.setData(dataSource[0])
//        heartButton.setImage(cellData.heartImage, for: .normal)
        historyButtonText = "\(dataSource[0].mumentCount)개의 뮤멘트가 있는 히스토리 보러가기"
    }
}

// MARK: - UI
extension MumentDetailVC {
    
    private func setLayout() {
        
//        mumentCardView.makeRounded(cornerRadius: 11)
//        mumentCardView.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.5,radius: 8.0)
        view.addSubviews([navigationBarView,mumentCardView,historyButton])
        
        navigationBarView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        mumentCardView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(27)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        historyButton.snp.makeConstraints{
            $0.top.equalTo(mumentCardView.snp.bottom).offset(30)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
    }
}

