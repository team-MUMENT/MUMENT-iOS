//
//  SongDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class SongDetailVC: BaseVC {
   
    // MARK: - Properties
    private let navigationBarView = UIView()
    private let songInfoView = SongInfoView()
    private let mumentTV = UITableView()
    
    var myMumentDataSource: [MumentCardBySongModel] = MumentCardBySongModel.myMumentSampleData
    var allMumentsDataSource: [MumentCardBySongModel] = MumentCardBySongModel.allMumentsSampleData

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
    }
    
    // MARK: - Functions
    private func setTV() {
        mumentTV.delegate = self
        mumentTV.dataSource = self
        
        mumentTV.register(cell: MumentCardBySongTVC.self, forCellReuseIdentifier: MumentCardBySongTVC.className)
        
//        mumentTV.estimatedRowHeight = 44
//        mumentTV.rowHeight = 48
        mumentTV.separatorStyle = .none
        mumentTV.showsVerticalScrollIndicator = false
    }
}

// MARK: - UI
extension SongDetailVC {
    
    private func setLayout() {
        view.addSubviews([navigationBarView,songInfoView,mumentTV])
        
        navigationBarView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        songInfoView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
        
        mumentTV.snp.makeConstraints{
            $0.top.equalTo(songInfoView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

// MARK: - UITableViewDataSource
extension SongDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return myMumentDataSource.count
        case 1:
            return allMumentsDataSource.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.setData(myMumentDataSource[0])
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentCardBySongTVC.className, for: indexPath) as? MumentCardBySongTVC else {
                return UITableViewCell()
            }
            cell.setData(allMumentsDataSource[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension SongDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0,1:
            cellHeight = 200
        default:
            cellHeight = 0
        }
        return cellHeight
    }
}

