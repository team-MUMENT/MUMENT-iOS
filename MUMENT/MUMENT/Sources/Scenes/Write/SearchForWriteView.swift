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
                titleLabel.snp.makeConstraints {
                    $0.height.equalTo(0)
                }
            }
        }
    }
    
    var searchResultData: SearchResultResponseModel = []
    var recentSearchData: SearchResultResponseModel = [] {
        didSet {
            recentSearchData.isEmpty ? closeRecentSearchTitleView() : openRecentSearchTitleView()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        fetchSearchResultData()
        setLayout()
        setResultTV()
        setRecentSearchEmptyView()
        setSearchBar()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fetchSearchResultData()
        setLayout()
        setResultTV()
        setRecentSearchEmptyView()
        setSearchBar()
    }
    
    // MARK: - Functions
    private func fetchSearchResultData() {
        if let localData = SearchResultResponseModelElement.getSearchResultModelFromUserDefaults(forKey: UserDefaults.Keys.recentSearch) {
            recentSearchData = localData
        } else {
            SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
            fetchSearchResultData()
        }
        resultTV.reloadData()
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
        self.recentSearchEmptyView.isHidden = !(self.recentSearchData.isEmpty)
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

// MARK: - UISearchBarDelegate
extension SearchForWriteView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
        
        getSearchResult(keyword: searchBar.searchTextField.text ?? "") { result in
            self.searchResultData = result
            self.searchTVType = .searchResult
            self.resultTV.reloadData()
            self.setSearchResultEmptyView(keyword: searchBar.searchTextField.text ?? "")
            self.closeRecentSearchTitleView()
        }
    }
}

// MARK: - Network
extension SearchForWriteView {
    func getSearchResult(keyword: String, completion: @escaping (SearchResultResponseModel) -> (Void)) {
        SearchAPI.shared.getMusicSearch(keyword: keyword) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? SearchResultResponseModel {
                    completion(result)
                }
            default:
                print("네트워크 연결 실패")
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchForWriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTVType {
        case .recentSearch:
            return recentSearchData.count
        case .searchResult:
            return searchResultData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchTVType {
        case .recentSearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTVC.className) as? RecentSearchTVC else { return UITableViewCell()}
            cell.setData(data: recentSearchData.reversed()[indexPath.row])
            cell.removeButton.removeTarget(nil, action: nil, for: .allEvents)
            cell.removeButton.press {
                self.recentSearchData.remove(at: self.recentSearchData.count - indexPath.row - 1)
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
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
        switch searchTVType {
        case .recentSearch:
            NotificationCenter.default.post(name: .sendSearchResult, object: recentSearchData.reversed()[indexPath.row])
            recentSearchData.append(recentSearchData.reversed()[indexPath.row])
            recentSearchData.remove(at: self.recentSearchData.count - indexPath.row - 2)
            SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            
        case .searchResult:
            if recentSearchData.contains(searchResultData[indexPath.row]) {
                recentSearchData.append(recentSearchData[indexPath.row])
                recentSearchData.remove(at: indexPath.row)
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            } else {
                recentSearchData.append(searchResultData[indexPath.row])
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            }
            NotificationCenter.default.post(name: .sendSearchResult, object: searchResultData[indexPath.row])
        }
        print("\(indexPath.row) cell select")
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
            $0.top.equalTo(titleLabel.snp.bottom)
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
