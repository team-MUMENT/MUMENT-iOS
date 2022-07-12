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
    let contentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .mumentB4M14
        $0.textColor = .mGray1
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mBlue3
                contentLabel.font = .mumentB3B14
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
            $0.edges.equalToSuperview()
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
