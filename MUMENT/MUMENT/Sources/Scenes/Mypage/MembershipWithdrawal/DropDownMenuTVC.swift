//
//  DropDownTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/12/12.
//

import UIKit
import SnapKit
import Then

final class DropDownMenuTVC: UITableViewCell {
    
    // MARK: - Components
    private let titleLabel = UILabel().then {
        $0.textColor = .mBlack1
        $0.font = .mumentB3M14
    }
    
    private let radioButtonImage = UIImageView().then {
        $0.image = UIImage(named: "reportBtnUnselected")
    }
    
    //MARK: - Properties
    var isSelectedTVC: Bool = false {
        didSet {
            radioButtonImage.image = isSelectedTVC ? UIImage(named: "reportBtnSelected") : UIImage(named: "reportBtnUnselected")
        }
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        selectionStyle = .none
        self.backgroundColor = .mGray5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setTitle(_ title:String) {
        titleLabel.text = title
    }
    
    func toggleSelectedStatus() {
        isSelectedTVC.toggle()
    }
}

// MARK: - UI
extension DropDownMenuTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel, radioButtonImage])
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(13)
            $0.centerY.equalToSuperview()
        }
        
        radioButtonImage.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(13)
            $0.centerY.equalToSuperview()
        }
    }
}
