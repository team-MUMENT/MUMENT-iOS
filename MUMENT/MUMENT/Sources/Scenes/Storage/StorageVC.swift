//
//  StorageVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then

class StorageVC: BaseVC {
    
    // MARK: - Properties
    private let naviView = DefaultNavigationView().then {
        $0.setTitleLabel(title: "보관함")
    }
    
    private let profileButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentStorageProfile"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    // SegmentedControl 담을 뷰
    private lazy var containerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var segmentControl = UISegmentedControl().then {
        $0.selectedSegmentTintColor = .clear
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        $0.insertSegment(withTitle: "나의 뮤멘트", at: 0, animated: true)
        $0.insertSegment(withTitle: "좋아요한 뮤멘트", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
                
        /// 선택 되어 있지 않을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mGray1,
            NSAttributedString.Key.font: UIFont.mumentH3B16
        ], for: .normal)
        
        /// 선택 되었을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mPurple1,
            NSAttributedString.Key.font: UIFont.mumentH3B16,
        ], for: .selected)
        
        $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        $0.selectedSegmentIndex = 0
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = .mPurple1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// 움직일 underLineView의 leadingAnchor 따로 작성
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    
    private let myMumentListCV = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = .green
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderLayout()
        setSegmentLaysout()
        
        setCollectionView()
    }
    
    // MARK: - Function
    func setCollectionView() {
        self.myMumentListCV.register(StorageCVC.self, forCellWithReuseIdentifier: StorageCVC.className)
        myMumentListCV.delegate = self
        myMumentListCV.dataSource = self
    }

    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.leadingDistance.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
    
    
    @objc private func segementClicked() {
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        
        if segmentIndex == 0 {
                
            
        }else {
          
            
        }
    }

}

// MARK: - UI
extension StorageVC {
    private func setHeaderLayout() {
        view.addSubviews([naviView, profileButton,containerView,myMumentListCV])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57.adjustedH)
        }
        
        profileButton.snp.makeConstraints{
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            $0.width.height.equalTo(30.adjustedH)
        }
        
        containerView.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50.adjustedH)
        }
        
        myMumentListCV.snp.makeConstraints{
            $0.top.equalTo(containerView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setSegmentLaysout() {
        containerView.addSubViews([segmentControl,underLineView])
        
        segmentControl.snp.makeConstraints{
            $0.top.leading.centerX.centerY.equalTo(containerView)
        }
        
        underLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.height.equalTo(2.adjustedH)
            $0.width.equalTo(segmentControl.snp.width).dividedBy(segmentControl.numberOfSegments)
            
        }
        
        NSLayoutConstraint.activate([leadingDistance])
    }
    
}

// MARK: - CollectionView UI
extension StorageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StorageCVC.className ,for: indexPath) as? StorageCVC
        else {
            return UICollectionViewCell()
        }
        cell.setData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}


// MARK: - SwiftUI Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        StorageVC().showPreview(.iPhone13mini)
    }
}
#endif
