//
//  DropDownVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/12/12.
//

import UIKit
import SnapKit
import Then

protocol DropDownMenuViewDelegate{
    func handleTVCSelectedEvent(_ menuLabel: String)
}

final class DropDownMenuView: UIView {
    
    // MARK: - Properties
    private var dropDownMenuData: [String] = ["컨텐츠가 부족해요", "원하는 곡이 없어요", "뮤멘트 기록 방식이 불편해요", "알람이 너무 자주와요", "앱 장애가 많아요", "기타"]
    
    private var delegate: DropDownMenuViewDelegate?
    
    private var selectedTVCIndex: Int = -1
    
    // MARK: - Components
    private let dropDownMenuTV: UITableView = UITableView().then{
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setTV()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
    }
    
    // MARK: - Functions
    private func setTV() {
        dropDownMenuTV.do{
            $0.backgroundColor = .mGray5
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = true
            $0.register(DropDownMenuTVC.self, forCellReuseIdentifier: DropDownMenuTVC.className)
            $0.isScrollEnabled = false
        }
    }
    
    func setDelegate(delegate: DropDownMenuViewDelegate){
        self.delegate = delegate
    }
}

// MARK: - UI
extension DropDownMenuView {
    
    private func setLayout() {
        self.addSubviews([dropDownMenuTV])
        
        dropDownMenuTV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension DropDownMenuView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownMenuTVC.className, for: indexPath) as? DropDownMenuTVC else {
            return UITableViewCell()
        }
        
        cell.setTitle(dropDownMenuData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownMenuData.count
    }
}

// MARK: - UITableViewDelegate
extension DropDownMenuView: UITableViewDelegate {
    
    // ???: 이 메소드를 안 써주면 셀을 클릭해도 라디오 버튼 이미지가 안 변함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = UIView()
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTVCIndex == -1 {
            let selectedCell = dropDownMenuTV.cellForRow(at: indexPath)! as! DropDownMenuTVC
            selectedCell.toggleSelectedStatus()
            
            selectedTVCIndex = indexPath.row
            
        } else if selectedTVCIndex != indexPath.row {
            let newlySelectedCell = dropDownMenuTV.cellForRow(at: indexPath)! as! DropDownMenuTVC
            newlySelectedCell.toggleSelectedStatus()
            
            let selectedCell = dropDownMenuTV.cellForRow(at: IndexPath(row: selectedTVCIndex, section: 0))! as! DropDownMenuTVC
            selectedCell.toggleSelectedStatus()
            
            selectedTVCIndex = indexPath.row
        }
        let menuLabel = dropDownMenuData[indexPath.row]
        self.delegate?.handleTVCSelectedEvent(menuLabel)
    }
}
