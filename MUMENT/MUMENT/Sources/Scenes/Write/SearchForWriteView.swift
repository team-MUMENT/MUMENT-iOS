//
//  SearchForWriteView.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/18.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class SearchForWriteView: UIView {
    
    // MARK: - Properties
    private let searchTextField = MumentSearchTextField()
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
    
    // MARK: Properties
    private var searchTVType: SearchTVType = .recentSearch {
        didSet {
            switch searchTVType {
            case .recentSearch:
                self.openRecentSearchTitleView()
            case .searchResult:
                self.closeRecentSearchTitleView()
            }
        }
    }
    
    private var searchResultData: SearchResultResponseModel = []
    private var recentSearchData: SearchResultResponseModel = []
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setLayout()
        self.setResultTV()
        self.fetchSearchResultData()
        self.setRecentSearchEmptyView()
        self.setSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func fetchSearchResultData() {
        if self.searchTVType == .recentSearch {
            if let localData = SearchResultResponseModelElement.getSearchResultModelFromUserDefaults(forKey: UserDefaults.Keys.recentSearch) {
                self.recentSearchData = localData
                self.recentSearchData.isEmpty ? self.closeRecentSearchTitleView() : self.openRecentSearchTitleView()
                self.setRecentSearchEmptyView()
            } else {
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
                self.fetchSearchResultData()
            }
            self.resultTV.reloadData()
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
    
    private func setSearchTextField() {
        searchTextField.delegate = self
        self.searchTextField.clearButton.rx.tap
            .bind {
                self.searchTVType = .recentSearch
                self.resultTV.reloadData()
                self.openRecentSearchTitleView()
                self.searchResultEmptyView.isHidden = true
                self.recentSearchEmptyView.isHidden = !self.recentSearchData.isEmpty
            }
            .disposed(by: self.disposeBag)
    }
    
    private func setRecentSearchEmptyView() {
        self.recentSearchEmptyView.isHidden = !(self.recentSearchData.isEmpty)
    }
    
    private func setSearchResultEmptyView(keyword: String) {
        self.searchResultEmptyView.setSearchKeyword(keyword: keyword)
        self.searchResultEmptyView.isHidden = !(searchResultData.isEmpty)
    }
    
    private func openRecentSearchTitleView() {
        if !self.recentSearchData.isEmpty {
            DispatchQueue.main.async {
                self.titleLabel.isHidden = false
            }
            self.titleLabel.snp.updateConstraints { make in
                make.height.equalTo(20)
            }
            self.resultTV.snp.remakeConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    private func closeRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.titleLabel.isHidden = true
        }
        self.titleLabel.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        self.resultTV.snp.remakeConstraints { make in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITextFieldDelegate
extension SearchForWriteView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.getSearchResult(keyword: self.searchTextField.text ?? "") { result in
            self.searchResultData = result
            self.searchTVType = .searchResult
            self.resultTV.reloadData()
            self.setSearchResultEmptyView(keyword: self.searchTextField.text ?? "")
            self.closeRecentSearchTitleView()
            self.recentSearchEmptyView.isHidden = true
        }
        
        return true
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
                self.fetchSearchResultData()
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
        self.addSubviews([searchTextField, titleLabel, resultTV, recentSearchEmptyView, searchResultEmptyView])
        
        self.searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        self.resultTV.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
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
