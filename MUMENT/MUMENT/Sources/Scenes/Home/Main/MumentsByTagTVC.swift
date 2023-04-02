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
    
    // MARK: - Components
    lazy var titleLabel = UILabel().then{
        $0.textColor = .mBlack1
        $0.font = .mumentH2B18
    }
    private let mumentCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: .zero, left: 15, bottom: .zero, right: 20)
        $0.register(MumentsByTagCVC.self, forCellWithReuseIdentifier: MumentsByTagCVC.className)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        $0.setCollectionViewLayout(layout, animated: false)
    }
    
    // MARK: - Properties
    weak var delegate: MumentsByTagCVCDelegate?
    var mumentsByTagData: [MumentsByTagResponseModel.MumentList] = []
    
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
    }
    
    func setData(_ cellData: MumentsByTagResponseModel){
        self.titleLabel.text = cellData.title
        self.mumentsByTagData = cellData.mumentList
        self.mumentCV.reloadData()
    }
}

// MARK: - UI
extension MumentsByTagTVC {
    
    private func setUI() {
        self.backgroundColor = .mBgwhite
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        
        self.addSubviews([titleLabel,mumentCV])
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        mumentCV.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
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
