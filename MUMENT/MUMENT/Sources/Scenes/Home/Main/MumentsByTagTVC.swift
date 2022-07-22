//
//  MumentsByTagTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class MumentsByTagTVC: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: MumentsByTagCVCDelegate?
    var dataSource: [MumentsByTagModel] = MumentsByTagModel.sampleData
    var mumentsByTagData: [MumentsByTagResponseModel.MumentList] = []
    var titleDataSource: MumentsByTagTitleModel = MumentsByTagTitleModel.sampleData
    lazy var titleLabel = UILabel().then{
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
        setData(titleDataSource)
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
        mumentCV.register(MumentsByTagCVC.self, forCellWithReuseIdentifier: MumentsByTagCVC.className)
        
        mumentCV.showsHorizontalScrollIndicator = false
        CVFlowLayout.scrollDirection = .horizontal
    }
    
    func setData(_ cellData: MumentsByTagTitleModel){
        titleLabel.text = "\(cellData.title)을 느낀 순간"
    }
    
    func setData(_ cellData: MumentsByTagResponseModel){
        titleLabel.text = cellData.title
        mumentsByTagData = cellData.mumentList
        mumentCV.reloadData()
    }
}

// MARK: - UI
extension MumentsByTagTVC {
    
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
extension MumentsByTagTVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MumentsByTagCVC {
            cell.isSelected = true
        }
        self.delegate?.mumentsByTagCVCSelected(data: mumentsByTagData[indexPath.row])
    }
}

// MARK: - UICollectionViewDataSource
extension MumentsByTagTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mumentsByTagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MumentsByTagCVC.className, for: indexPath) as?  MumentsByTagCVC else {
            return UICollectionViewCell()
        }
        
        cell.setData(mumentsByTagData[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MumentsByTagTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 200
        let cellHeight = 200
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

