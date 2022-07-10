//
//  HomeVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit

class HomeVC: BaseVC {
   
    // MARK: - Properties
    private let headerView = TVHeader()
    private let TV = UITableView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
    }
    
    // MARK: - Functions
    private func setTV() {
        TV.delegate = self
        TV.dataSource = self
        
        TV.register(cell: SearchBoxTVC.self, forCellReuseIdentifier: SearchBoxTVC.className)
        TV.register(cell: CarouselTVC.self, forCellReuseIdentifier: CarouselTVC.className)
        TV.register(cell: RecentMumentsTVC.self, forCellReuseIdentifier: RecentMumentsTVC.className)
        TV.register(cell: MumentForTodayTVC.self, forCellReuseIdentifier: MumentForTodayTVC.className)
        TV.register(cell: MumentsByTagTVC.self, forCellReuseIdentifier: MumentsByTagTVC.className)
        
        TV.estimatedRowHeight = 44
        TV.rowHeight = 48
        TV.separatorStyle = .none
        TV.showsVerticalScrollIndicator = false
    }
}

// MARK: - UI
extension HomeVC {
    
    private func setLayout() {
        view.addSubviews([headerView,TV])
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52.adjustedH)
        }
        
        TV.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBoxTVC.className, for: indexPath) as? SearchBoxTVC else {
                return UITableViewCell()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTVC.className, for: indexPath) as? CarouselTVC else {
                return UITableViewCell()
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentMumentsTVC.className, for: indexPath) as? RecentMumentsTVC else {
                return UITableViewCell()
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentForTodayTVC.className, for: indexPath) as? MumentForTodayTVC else {
                return UITableViewCell()
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentsByTagTVC.className, for: indexPath) as? MumentsByTagTVC else {
                return UITableViewCell()
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0:
            cellHeight = 100.adjustedH
        case 1:
            cellHeight = 300.adjustedH
        case 2 :
            cellHeight = 300.adjustedH
        case 3 :
            cellHeight = 300.adjustedH
        case 4 :
            cellHeight = 300.adjustedH
        default:
            cellHeight = 0
        }
        return cellHeight
    }
}

