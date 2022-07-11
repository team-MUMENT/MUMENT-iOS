//
//  WriteTagCVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class WriteTagCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let contentLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mBlue2
            } else {
                contentView.backgroundColor = .white
            }
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setUI()
    }
    
    // MARK: - UI
    private func setLayout() {
        contentView.addSubviews([contentLabel])
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.makeRounded(cornerRadius: contentView.frame.height / 2)
        contentView.addShadow(location: .nadoBotttom)
    }
    
    // MARK: - Functions
    func setData(data: String) {
        contentLabel.text = data
    }
}
