//
//  SearchVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class SearchVC: BaseVC {
    
    // MARK: - Properties
    private let naviView = UIView()
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentIconBack"), for: .normal)
    }
    private let searchBar = UISearchBar().then {
        $0.setImage(UIImage(named: "mumentSearch"), for: .search, state: .normal)
        $0.barTintColor = .mGray5
        $0.makeRounded(cornerRadius: 11.adjustedH)
        $0.placeholder = "곡, 아티스트"
        $0.searchTextField.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.mBgwhite.cgColor
    }
    private let recentSearchLabel = UILabel().then {
        $0.text = "최근 검색한 곡"
        $0.font = .mumentH2B18
        $0.textColor = .mBlack1
    }
    private let allClearButton = UIButton(type: .system).then {
        $0.setTitle("모두 삭제", for: .normal)
        $0.titleLabel?.font = .mumentB8M12
        $0.setTitleColor(.mGray2, for: .normal)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAllClearButton()
    }
    
    // MARK: - Functions
    private func setAllClearButton() {
        
    }
}

// MARK: - UI
extension SearchVC {
    private func setLayout() {
        setNaviViewLayout()
        view.addSubviews([naviView, recentSearchLabel, allClearButton])
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(naviView.snp.bottom).offset(40.adjustedH)
        }
        
        allClearButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(48.adjustedW)
        }
    }
    
    private func setNaviViewLayout() {
        naviView.addSubviews([backButton, searchBar])
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(12)
            $0.height.equalTo(24)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
    }
}
