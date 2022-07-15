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
        $0.searchTextField.font = .mumentB4M14
        $0.searchTextField.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.mBgwhite.cgColor
    }
    private let recentSearchTitleView = UIView()
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
    private let resultTV = UITableView().then {
        $0.separatorStyle = .none
    }
    
    var recentSearchDummyData = [MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트")]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAllClearButton()
        setResultTV()
    }
    
    // MARK: - Functions
    private func setAllClearButton() {
        
    }
    
    private func setResultTV() {
        resultTV.delegate = self
        resultTV.dataSource = self
        resultTV.register(cell: RecentSearchTVC.self, forCellReuseIdentifier: RecentSearchTVC.className)
        resultTV.rowHeight = 65
        resultTV.backgroundColor = .clear
    }
}

// MARK: - UI
extension SearchVC {
    private func setLayout() {
        setNaviViewLayout()
        setRecentSearchTitleView()
        view.addSubviews([naviView, recentSearchTitleView, resultTV])
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        recentSearchTitleView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(40.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        resultTV.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
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
    
    private func setRecentSearchTitleView() {
        recentSearchTitleView.addSubviews([recentSearchLabel, allClearButton])
        
        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
        }
        
        allClearButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(48.adjustedW)
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchDummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTVC.className) as? RecentSearchTVC else { return UITableViewCell()}
        cell.setData(data: recentSearchDummyData[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) cell select")
    }
}
