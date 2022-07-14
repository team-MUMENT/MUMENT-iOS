//
//  HomeVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit

class HomeVC: BaseVC {
   
    // MARK: - Properties
    private let headerView = HomeTVHeader()
    private let homeTV = UITableView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTV()
        setLayout()
    }
    
    // MARK: - Functions
    private func setTV() {
        homeTV.delegate = self
        homeTV.dataSource = self
        
        homeTV.register(cell: CarouselTVC.self, forCellReuseIdentifier: CarouselTVC.className)
        homeTV.register(cell: RecentMumentsTVC.self, forCellReuseIdentifier: RecentMumentsTVC.className)
        homeTV.register(cell: MumentForTodayTVC.self, forCellReuseIdentifier: MumentForTodayTVC.className)
        homeTV.register(cell: MumentsByTagTVC.self, forCellReuseIdentifier: MumentsByTagTVC.className)
        
        homeTV.estimatedRowHeight = 44
        homeTV.rowHeight = 48
        homeTV.separatorStyle = .none
        homeTV.showsVerticalScrollIndicator = false
    }
}

// MARK: - UI
extension HomeVC {
    
    private func setLayout() {
        view.addSubviews([headerView,homeTV])
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(107.adjustedH)
        }
        
        homeTV.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTVC.className, for: indexPath) as? CarouselTVC else {
                return UITableViewCell()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentMumentsTVC.className, for: indexPath) as? RecentMumentsTVC else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentForTodayTVC.className, for: indexPath) as? MumentForTodayTVC else {
                return UITableViewCell()
            }
            return cell
        case 3:
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
            cellHeight = 300.adjustedH
        case 1...3:
            cellHeight = 300.adjustedH
        default:
            cellHeight = 0
        }
        return cellHeight
    }
}

//// MARK: - SwiftUI Preview
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct ViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview(.iPhone13mini)
//    }
//}
//#endif
