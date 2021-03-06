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
    
    var dataSource: [MumentsOfRevisitedModel] = MumentsOfRevisitedModel.sampleData
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
        setCV()
        setLayout()
        selectionStyle = .none
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
        mumentCV.backgroundColor = .mBgwhite
        self.backgroundColor = .mBgwhite
    }
    
    func setData(_ cellData: [MumentsOfRevisitedResponseModel.AgainMument]){
        mumentsOfRevisitedData = cellData
        mumentCV.reloadData()
    }
}

// MARK: - UI
extension MumentsOfRevisitedTVC {
    
    private func setLayout() {
        
        self.addSubviews([titleLabel,mumentCV])
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        mumentCV.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
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
