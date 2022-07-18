//
//  SearchForWriteView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/18.
//

import UIKit
import SnapKit
import Then

class SearchForWriteView: UIView {
    
    // MARK: - Properties
    private let searchBar = UISearchBar().then {
        $0.setImage(UIImage(named: "mumentSearch"), for: .search, state: .normal)
        $0.barTintColor = .mGray5
        $0.makeRounded(cornerRadius: 11.adjustedH)
        $0.placeholder = " 곡, 아티스트"
        $0.searchTextField.font = .mumentB4M14
        $0.searchTextField.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.mBgwhite.cgColor
    }
    private let titleLabel = UILabel().then {
        $0.font = .mumentH2B18
        $0.textColor = .mBlack1
        $0.text = "최근 검색한 곡"
    }
    private let resultTV = UITableView().then {
        $0.separatorStyle = .none
    }
    private let recentSearchEmptyView = RecentSearchEmptyView().then {
        $0.isHidden = true
        $0.setUIForBottonSheet()
    }
    private let searchResultEmptyView = SearchResultEmptyView().then {
        $0.isHidden = true
    }
    
    var searchTVType: SearchTVType = .recentSearch {
        didSet {
            switch searchTVType {
            case .recentSearch:
                searchResultEmptyView.isHidden = true
            case .searchResult:
                recentSearchEmptyView.isHidden = true
                titleLabel.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
            }
        }
    }
    
    var searchResultData: [MusicForSearchModel] = [MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트")]
    var recentSearchDummyData = [MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트"), MusicForSearchModel(imageUrl: "https://avatars.githubusercontent.com/u/108561249?s=400&u=96c3e4200232298c52c06e429bd323cad25bc98c&v=4", title: "노래", artist: "아티스트")] {
        didSet {
            recentSearchDummyData.isEmpty ? closeRecentSearchTitleView() : openRecentSearchTitleView()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setResultTV()
        setRecentSearchEmptyView()
        setSearchBar()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
        setResultTV()
        setRecentSearchEmptyView()
        setSearchBar()
    }
    
    // MARK: - Functions
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
        self.recentSearchEmptyView.isHidden = !(self.recentSearchDummyData.isEmpty)
    }
    
    private func setSearchResultEmptyView(keyword: String) {
        searchResultEmptyView.setSearchKeyword(keyword: keyword)
        searchResultEmptyView.isHidden = !(searchResultData.isEmpty)
    }
    
    private func openRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.titleLabel.isHidden = false
        }
    }
    
    private func closeRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.titleLabel.isHidden = true
        }
    }
}

// MARK: - UI
extension SearchForWriteView {
    private func setLayout() {
        self.addSubviews([searchBar, titleLabel, resultTV, recentSearchEmptyView, searchResultEmptyView])
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(40.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultTV.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedH)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        recentSearchEmptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        searchResultEmptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchForWriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTVType {
        case .recentSearch:
            return recentSearchDummyData.count
        case .searchResult:
            return searchResultData.count
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
            cell.setData(data: searchResultData[indexPath.row])
            return cell
        }
        
    }
}

// MARK: - UITableViewDelegate
extension SearchForWriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) cell select")
    }
}

// MARK: - UISearchBarDelegate
extension SearchForWriteView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
        searchTVType = .searchResult
        self.resultTV.reloadData()
        setSearchResultEmptyView(keyword: searchBar.searchTextField.text ?? "")
        closeRecentSearchTitleView()
    }
}
