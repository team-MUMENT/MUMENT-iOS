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
    weak var delegate: MumentsOfRevisitedCVCDelegate?
    
    var mumentsOfRevisitedData: [MumentsOfRevisitedResponseModel.AgainMument] = []
    
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
        
        self.setCV()
        self.setLayout()
        self.setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setCV() {
        self.mumentCV.delegate = self
        self.mumentCV.dataSource = self
        
        self.mumentCV.register(MumentsOfRevisitedCVC.self, forCellWithReuseIdentifier: MumentsOfRevisitedCVC.className)
        
        self.mumentCV.showsHorizontalScrollIndicator = false
        self.CVFlowLayout.scrollDirection = .horizontal
        self.mumentCV.backgroundColor = .mBgwhite
        
        self.mumentCV.contentInset.left = 15
        self.mumentCV.contentInset.right = 15
    }
    
    func setData(_ cellData: [MumentsOfRevisitedResponseModel.AgainMument]){
        self.mumentsOfRevisitedData = cellData
        self.mumentCV.reloadData()
    }
}

// MARK: - UI
extension MumentsOfRevisitedTVC {
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        
        self.addSubviews([titleLabel,mumentCV])
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        mumentCV.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension MumentsOfRevisitedTVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MumentsOfRevisitedCVC {
            cell.isSelected = true
        }
        self.delegate?.mumentsOfRevisitedCVCSelected(data: mumentsOfRevisitedData[indexPath.row])
    }
}

// MARK: - UICollectionViewDataSource
extension MumentsOfRevisitedTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mumentsOfRevisitedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MumentsOfRevisitedCVC.className, for: indexPath) as?  MumentsOfRevisitedCVC else {
            return UICollectionViewCell()
        }
        cell.setData(mumentsOfRevisitedData[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MumentsOfRevisitedTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 160
        let cellHeight = 275
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
