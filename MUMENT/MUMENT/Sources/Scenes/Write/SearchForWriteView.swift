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
        $0.setImage(UIImage(named: "mumentDelete2"), for: .clear, state: .normal)
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
                self.searchResultEmptyView.isHidden = true
            case .searchResult:
                self.recentSearchEmptyView.isHidden = true
                self.titleLabel.snp.makeConstraints {
                    $0.height.equalTo(0)
                }
            }
        }
    }
    
    var searchResultData: SearchResultResponseModel = []
    var recentSearchData: SearchResultResponseModel = [] {
        didSet {
            self.recentSearchData.isEmpty ? closeRecentSearchTitleView() : openRecentSearchTitleView()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.fetchSearchResultData()
        self.setLayout()
        self.setResultTV()
        self.setRecentSearchEmptyView()
        self.setSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func fetchSearchResultData() {
        if let localData = SearchResultResponseModelElement.getSearchResultModelFromUserDefaults(forKey: UserDefaults.Keys.recentSearch) {
            self.recentSearchData = localData
        } else {
            SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
            self.fetchSearchResultData()
        }
        self.resultTV.reloadData()
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
        self.searchResultEmptyView.setSearchKeyword(keyword: keyword)
        self.searchResultEmptyView.isHidden = !(searchResultData.isEmpty)
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
            NotificationCenter.default.post(name: .sendSearchResult, object: self.recentSearchData.reversed()[indexPath.row])
            self.recentSearchData.append(self.recentSearchData.reversed()[indexPath.row])
            self.recentSearchData.remove(at: self.recentSearchData.count - indexPath.row - 2)
            SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            
        case .searchResult:
            if self.recentSearchData.contains(self.searchResultData[indexPath.row]) {
                self.recentSearchData.append(self.recentSearchData[indexPath.row])
                self.recentSearchData.remove(at: indexPath.row)
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            } else {
                self.recentSearchData.append(self.searchResultData[indexPath.row])
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            }
            NotificationCenter.default.post(name: .sendSearchResult, object: self.searchResultData[indexPath.row])
        }
        print("\(indexPath.row) cell select")
    }
}

// MARK: - UI
extension SearchForWriteView {
    private func setLayout() {
        self.addSubviews([searchBar, titleLabel, resultTV, recentSearchEmptyView, searchResultEmptyView])
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(40.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        self.resultTV.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.recentSearchEmptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.searchResultEmptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
