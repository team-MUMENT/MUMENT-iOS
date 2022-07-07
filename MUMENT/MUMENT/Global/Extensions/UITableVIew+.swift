//
//  UITableVIew+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withType cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not find cell with reuseID \(T.className)")
        }
        return cell
    }
    
    func register<T>(cell: T.Type,
                     forCellReuseIdentifier reuseIdentifier: String = T.className) where T: UITableViewCell {
        register(cell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// TableView 하단 빈 셀 없애는 메서드
    func setBottomEmptyView() {
        let dummyView = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 0))
        self.tableFooterView = dummyView
    }
    
    func fitContentInset(inset: UIEdgeInsets!) {
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
    
    /// TableView 마지막 separator, 빈 셀 separator 숨기는 메서드
    func removeSeparatorsOfEmptyCellsAndLastCell() {
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
    }
}
