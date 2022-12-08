//
//  SelectedTagsView.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/08.
//

import UIKit
import SnapKit
import Then

final class TagSectionView: UIView {
    
    let selectedTagsStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 10
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .mGray5
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(selectedTagsStackView)
                
        selectedTagsStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(35)
            $0.centerY.equalToSuperview()
        }
    }

}
