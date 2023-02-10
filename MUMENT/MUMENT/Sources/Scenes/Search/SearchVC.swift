//
//  SearchVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/15.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class SearchVC: BaseVC {
    
    // MARK: - Properties
    private let naviView = UIView()
    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentIconBack"), for: .normal)
        $0.press {
            self.navigationController?.popViewController(animated: true)
        }
    }
    private let searchTextField: MumentSearchTextField = MumentSearchTextField()
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
    
    private var searchTVType: SearchTVType = .recentSearch {
        didSet {
            switch searchTVType {
            case .recentSearch:
                self.recentSearchData.isEmpty ? self.closeRecentSearchTitleView() : self.openRecentSearchTitleView()
            case .searchResult:
                self.closeRecentSearchTitleView()
            }
        }
    }
    
    // MARK: Properties
    private var searchResultData: SearchResultResponseModel = []
    private var recentSearchData: SearchResultResponseModel = []
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchSearchResultData()
        self.setLayout()
        self.setAllClearButton()
        self.setResultTV()
        self.setRecentSearchEmptyView()
        self.setSearchTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideTabbar()
        self.fetchSearchResultData()
    }
    
    // MARK: - Functions
    private func fetchSearchResultData() {
        if self.searchTVType == .recentSearch {
            if let localData = SearchResultResponseModelElement.getSearchResultModelFromUserDefaults(forKey: UserDefaults.Keys.recentSearch) {
                self.recentSearchData = localData
                self.recentSearchData.isEmpty ? closeRecentSearchTitleView() : openRecentSearchTitleView()
            } else {
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
                self.fetchSearchResultData()
            }
            self.resultTV.reloadData()
        }
    }
    
    private func setAllClearButton() {
        allClearButton.press { [weak self] in
            let mumentAlert = MumentAlertWithButtons(titleType: .onlyTitleLabel)
            mumentAlert.setTitle(title: """
최근 검색한 내역을
모두 삭제하시겠어요?
""")
            mumentAlert.OKButton.press {
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: [], forKey: UserDefaults.Keys.recentSearch)
                self?.fetchSearchResultData()
                self?.setRecentSearchEmptyView()
            }
            self?.present(mumentAlert, animated: true)
        }
    }
    
    private func setResultTV() {
        self.resultTV.delegate = self
        self.resultTV.dataSource = self
        self.resultTV.rowHeight = 65
        self.resultTV.backgroundColor = .clear
        self.resultTV.register(cell: RecentSearchTVC.self, forCellReuseIdentifier: RecentSearchTVC.className)
        self.resultTV.register(cell: SearchTVC.self, forCellReuseIdentifier: SearchTVC.className)
    }
    
    private func setSearchTextField() {
        self.searchTextField.delegate = self
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
        self.searchResultEmptyView.isHidden = !(self.searchResultData.isEmpty)
    }
    
    private func openRecentSearchTitleView() {
        if !self.recentSearchData.isEmpty {
            DispatchQueue.main.async {
                self.recentSearchTitleView.isHidden = false
            }
            self.recentSearchTitleView.snp.updateConstraints { make in
                make.height.equalTo(45)
            }
        }
    }
    
    private func closeRecentSearchTitleView() {
        DispatchQueue.main.async {
            self.recentSearchTitleView.isHidden = true
        }
        self.recentSearchTitleView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTVType {
        case .recentSearch:
            return self.recentSearchData.count
        case .searchResult:
            return self.searchResultData.count
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
                self.setRecentSearchEmptyView()
            }
            return cell
        case .searchResult:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.className) as? SearchTVC else { return UITableViewCell()}
            cell.setData(data: self.searchResultData[indexPath.row])
            return cell
        }
        
    }
}

// MARK: - Network
extension SearchVC {
    func getSearchResult(keyword: String, completion: @escaping (SearchResultResponseModel) -> (Void)) {
        self.startActivityIndicator()
        SearchAPI.shared.getMusicSearch(keyword: keyword) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? SearchResultResponseModel {
                    self.stopActivityIndicator()
                    completion(result)
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songDetailVC = SongDetailVC()
        
        switch searchTVType {
        case .recentSearch:
            songDetailVC.musicData = MusicDTO(
                id: self.recentSearchData.reversed()[indexPath.row].id,
                title: self.recentSearchData.reversed()[indexPath.row].name,
                artist: self.recentSearchData.reversed()[indexPath.row].artist,
                albumUrl: self.recentSearchData.reversed()[indexPath.row].image ?? ""
            )
            self.recentSearchData.append(self.recentSearchData.reversed()[indexPath.row])
            self.recentSearchData.remove(at: self.recentSearchData.count - indexPath.row - 2)
            SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
        case .searchResult:
            songDetailVC.musicData = MusicDTO(
                id: self.searchResultData[indexPath.row].id,
                title: self.searchResultData[indexPath.row].name,
                artist: searchResultData[indexPath.row].artist,
                albumUrl: self.searchResultData[indexPath.row].image ?? ""
            )
            if self.recentSearchData.contains(self.searchResultData[indexPath.row]) {
                self.recentSearchData.append(self.recentSearchData[indexPath.row])
                self.recentSearchData.remove(at: indexPath.row)
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            } else {
                self.recentSearchData.append(searchResultData[indexPath.row])
                SearchResultResponseModelElement.setSearchResultModelToUserDefaults(data: self.recentSearchData, forKey: UserDefaults.Keys.recentSearch)
            }
        }
        self.fetchSearchResultData()
        
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchVC: UITextFieldDelegate {
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

// MARK: - UI
extension SearchVC {
    private func setLayout() {
        setNaviViewLayout()
        setRecentSearchTitleView()
        view.addSubviews([naviView, recentSearchTitleView, resultTV, recentSearchEmptyView, searchResultEmptyView])
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        recentSearchTitleView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(30.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
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
        naviView.addSubviews([backButton, searchTextField])
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(12)
            $0.height.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(4)
        }
    }
    
    private func setRecentSearchTitleView() {
        recentSearchTitleView.addSubviews([recentSearchLabel, allClearButton])
        
        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        allClearButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(48.adjustedW)
            $0.height.equalTo(16.adjustedW)
        }
    }
}
