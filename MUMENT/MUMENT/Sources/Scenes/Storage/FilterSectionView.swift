//
//  FilterSectionView.swift
//  MUMENT
//
//  Created by 김담인 on 2022/12/03.
//

import UIKit
import SnapKit
import Then

final class FilterSectionView: UIView {
    
    // MARK: - Components
    let filterButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentFilterOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentFilterOn"), for: .selected)
        $0.contentMode = .scaleAspectFit
    }
        
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 15
    }
    
    let albumButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentAlbumOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentAlbumOn"), for: .selected)
        $0.contentMode = .scaleAspectFit
    }
    
    let listButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentListOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentListOn"), for: .selected)
        $0.isSelected = true
        $0.contentMode = .scaleAspectFit
    }
    
    private let storageBottomSheet = StorageBottomSheet()
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setFilterSectionLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFilterSectionLayout() {

        self.addSubViews([filterButton, buttonStackView])
        
        filterButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        [albumButton, listButton].forEach {
            self.buttonStackView.addArrangedSubview($0)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(55)
        }
    }
    
}
