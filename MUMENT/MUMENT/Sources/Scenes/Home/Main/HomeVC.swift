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
        setButtonActions()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    private func setTV() {
        homeTV.delegate = self
        homeTV.dataSource = self
        
        homeTV.register(cell: CarouselTVC.self, forCellReuseIdentifier: CarouselTVC.className)
        homeTV.register(cell: MumentsOfRevisitedTVC.self, forCellReuseIdentifier: MumentsOfRevisitedTVC.className)
        homeTV.register(cell: MumentForTodayTVC.self, forCellReuseIdentifier: MumentForTodayTVC.className)
        homeTV.register(cell: MumentsByTagTVC.self, forCellReuseIdentifier: MumentsByTagTVC.className)
        
        homeTV.estimatedRowHeight = 44
        homeTV.rowHeight = 48
        homeTV.separatorStyle = .none
        homeTV.showsVerticalScrollIndicator = false
    }
    
    private func setButtonActions(){
        headerView.searchButton.press{
            let searchVC = SearchVC()
            self.navigationController?.pushViewController(searchVC, animated: true)
            print("searchVC")
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let mumentDetailVC = MumentDetailVC()
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        print("mumentDetailVC")
    }
    
}

// MARK: - UI
extension HomeVC {
    
    private func setLayout() {
        
        view.addSubviews([headerView,homeTV])
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(107)
        }
        
        homeTV.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: - CarouselCVCDelegate
extension HomeVC: CarouselCVCDelegate {
    func carouselCVCSelected() {
        let songDetailVC = SongDetailVC()
        self.navigationController?.pushViewController(songDetailVC, animated: true)
        print("songDetailVC")
    }
}

// MARK: - MumentsOfRevisitedCVCDelegate
extension HomeVC: MumentsOfRevisitedCVCDelegate {
    func mumentsOfRevisitedCVCSelected() {
        let mumentDetailVC = MumentDetailVC()
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        print("mumentDetailVC")
    }
}

// MARK: - MumentsByTagCVCDelegate
extension HomeVC: MumentsByTagCVCDelegate {
    func mumentsByTagCVCSelected() {
        let mumentDetailVC = MumentDetailVC()
        self.navigationController?.pushViewController(mumentDetailVC, animated: true)
        print("mumentDetailVC")
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
            cell.delegate = self
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentForTodayTVC.className, for: indexPath) as? MumentForTodayTVC else {
                return UITableViewCell()
            }
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
            cell.mumentCardView.addGestureRecognizer(tapGestureRecognizer)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentsOfRevisitedTVC.className, for: indexPath) as? MumentsOfRevisitedTVC else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MumentsByTagTVC.className, for: indexPath) as? MumentsByTagTVC else {
                return UITableViewCell()
            }
            cell.delegate = self
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
            cellHeight = 300
        case 1:
            cellHeight = 300
        case 2:
            cellHeight = 350
        case 3:
            cellHeight = 280
        default:
            cellHeight = 0
        }
        return cellHeight
    }
}
