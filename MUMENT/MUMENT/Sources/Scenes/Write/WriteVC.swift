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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

// MARK: - UI
extension WriteVC {
    private func setLayout() {
        view.addSubviews([naviView])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52.adjustedH)
        }
    }
}
