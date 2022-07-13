//
//  RecentMumentsTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class MumentsOfRevisitedTVC: UITableViewCell {
    
    // MARK: - Properties
    var dataSource: [MumentsOfRevisitedModel] = MumentsOfRevisitedModel.sampleData
    lazy var titleLabel = UILabel().then{
            $0.text = "다시 들은 곡의 뮤멘트"
            $0.textColor = .mBlack1
            $0.font = .mumentH2B18
        }
    private lazy var mumentCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    private let CVFlowLayout = UICollectionViewFlowLayout()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCV()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setCV() {
        mumentCV.delegate = self
        mumentCV.dataSource = self
        mumentCV.register(MumentsOfRevisitedCVC.self, forCellWithReuseIdentifier: MumentsOfRevisitedCVC.className)
        
        mumentCV.showsHorizontalScrollIndicator = false
        CVFlowLayout.scrollDirection = .horizontal
    }
}

// MARK: - UI
extension MumentsOfRevisitedTVC {
    
    private func setLayout() {
        self.addSubviews([titleLabel])
        
        selectionStyle = .none
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension MumentsOfRevisitedTVC: UICollectionViewDelegate{
    


    
}

// MARK: - UICollectionViewDataSource
extension MumentsOfRevisitedTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MumentsOfRevisitedCVC.className, for: indexPath)
        if let cell = cell as? MumentsOfRevisitedCVC {
            cell.setData(dataSource[indexPath.row])
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MumentsOfRevisitedTVC: UICollectionViewDelegateFlowLayout {
}
