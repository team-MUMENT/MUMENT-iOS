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
    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentIconBack"), for: .normal)
        $0.press {
            self.navigationController?.popViewController(animated: true)
        }
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
    private let recentSearchEmptyView = RecentSearchEmptyView().then {
        $0.isHidden = true
    }
    private let searchResultEmptyView = SearchResultEmptyView().then {
        $0.isHidden = true
    }
    
    var searchTVType: SearchTVType = .recentSearch {
        didSet {
            recentSearchTitleView.snp.updateConstraints {
                switch searchTVType {
                case .recentSearch:
                    $0.height.equalTo(23)
                case .searchResult:
                    $0.height.equalTo(0)
                }
            }
        }
    }
    var resultSearch: [MusicForSearchModel] = [MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트")]
    var recentSearchDummyData = [MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트")]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAllClearButton()
        setResultTV()
        setRecentSearchEmptyView()
        setSearchBar()
    }
    
    // MARK: - Functions
    private func setAllClearButton() {
        allClearButton.press { [weak self] in
            self?.recentSearchDummyData = []
            self?.resultTV.reloadData()
            self?.setRecentSearchEmptyView()
        }
    }
    
    private func setResultTV() {
        resultTV.delegate = self
        resultTV.dataSource = self
        resultTV.rowHeight = 65
        resultTV.backgroundColor = .clear
        resultTV.register(cell: RecentSearchTVC.self, forCellReuseIdentifier: RecentSearchTVC.className)
        resultTV.register(cell: SearchTVC.self, forCellReuseIdentifier: SearchTVC.className)
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    
    private func setRecentSearchEmptyView() {
        recentSearchEmptyView.isHidden = !(recentSearchDummyData.isEmpty)
        recentSearchTitleView.isHidden = recentSearchDummyData.isEmpty
    private func openRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.recentSearchTitleView.isHidden = false
        }
    }
    
    private func closeRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.recentSearchTitleView.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTVType {
        case .recentSearch:
            return recentSearchDummyData.count
        case .searchResult:
            return resultSearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchTVType {
        case .recentSearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTVC.className) as? RecentSearchTVC else { return UITableViewCell()}
            cell.setData(data: recentSearchDummyData[indexPath.row])
            cell.removeButton.removeTarget(nil, action: nil, for: .allEvents)
            cell.removeButton.press {
                self.recentSearchDummyData.remove(at: indexPath.row)
                tableView.reloadData()
                self.setRecentSearchEmptyView()
            }
            return cell
        case .searchResult:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.className) as? SearchTVC else { return UITableViewCell()}
            cell.setData(data: resultSearch[indexPath.row])
            return cell
        }
        
    }
}

// MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) cell select")
    }
}

// MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
        searchTVType = .searchResult
        self.resultTV.reloadData()
    }
}

// MARK: - UI
extension SearchVC {
    private func setLayout() {
        setNaviViewLayout()
        setRecentSearchTitleView()
        view.addSubviews([naviView, recentSearchTitleView, resultTV, recentSearchEmptyView, searchResultEmptyView])
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        recentSearchTitleView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(30.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        resultTV.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchEmptyView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchResultEmptyView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTitleView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
