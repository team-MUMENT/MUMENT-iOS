//
//  StorageFilterTagCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/01/23.
//

import UIKit
import SnapKit
import Then

class StorageFilterTagCVC: UICollectionViewCell {
    
    // MARK: - Properties
    let contentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .mumentB4M14
        $0.textColor = .mGray1
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mBlue3
                contentLabel.font = .mumentB2B14
                contentLabel.textColor = .mBlue1
            } else {
                contentView.backgroundColor = .mGray5
                contentLabel.font = .mumentB4M14
                contentLabel.textColor = .mGray1
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
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(13)
        }
    }
    
    private func setUI() {
        contentView.backgroundColor = .mGray5
        contentView.makeRounded(cornerRadius: contentView.frame.height / 2)
    }
    
    // MARK: - Functions
    func setData(data: String) {
        contentLabel.text = data
    }
}

