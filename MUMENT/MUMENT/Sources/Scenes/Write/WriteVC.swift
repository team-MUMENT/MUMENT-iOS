//
//  WriteVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then

class WriteVC: BaseVC {
    
    // MARK: - Properties
    private let writeScrollView = UIScrollView()
    private let writeContentView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    private let naviView = DefaultNavigationView().then {
        $0.setTitleLabel(title: "기록하기")
    }
    private let resetButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentReset"), for: .normal)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

// MARK: - UI
extension WriteVC {
    private func setLayout() {
        view.addSubviews([writeScrollView])
        writeScrollView.addSubviews([writeContentView])
        writeContentView.addSubviews([naviView, resetButton])
        
        writeScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        writeContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(52.adjustedH)
        }
        
        resetButton.snp.makeConstraints {
            $0.centerY.equalTo(naviView)
            $0.width.height.equalTo(25.adjustedW)
            $0.rightMargin.equalToSuperview().inset(20)
        }
    }
}
