//
//  OnboardingVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

final class OnboardingVC: BaseVC {
    
    // MARK: - Properties
    private let CVFlowLayout = UICollectionViewFlowLayout()
    private lazy var CV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    private var dataSource: [OnboardingModel] = OnboardingModel.onboardingData
    
    private let pagingControl = UIPageControl().then{
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.hidesForSinglePage = true
        $0.currentPageIndicatorTintColor = .mPurple1
        $0.pageIndicatorTintColor = .mGray3
    }
    
    private let initiatingButton = MumentCompleteButton(isEnabled: false).then{
        $0.setTitle("시작하기", for: .normal)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        pagingControl.numberOfPages = dataSource.count
    }
    
    // MARK: - Functions
    private func setCV() {
        CV.delegate = self
        CV.dataSource = self
        CV.register(OnboardingCVC.self, forCellWithReuseIdentifier: OnboardingCVC.className)
        CV.showsHorizontalScrollIndicator = false
//        CV.isPagingEnabled = true
        
        CVFlowLayout.scrollDirection = .horizontal
        CVFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        CVFlowLayout.minimumInteritemSpacing = 0
    }
}

// MARK: - UI
extension OnboardingVC {
    
    private func setLayout() {
        view.addSubviews([CV,pagingControl,initiatingButton])
        
        CV.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
            
            pagingControl.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(38)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            
            initiatingButton.snp.makeConstraints{
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
                $0.height.equalTo(50)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingVC: UICollectionViewDelegate{
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        if let cell = collectionView.cellForItem(at: indexPath) as? OnboardingCVC {
    //            cell.isSelected = true
    //        }
    //        self.delegate?.carouselCVCSelected(data: increasedCarouselData[indexPath.row])
    
    // Test Code
    //        self.delegate?.carouselCVCSelected()
    //    }
    
    
}

// MARK: - UICollectionViewDataSource
extension OnboardingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVC.className, for: indexPath) as? OnboardingCVC else {
            return UICollectionViewCell()
            
        }
        cell.setData(dataSource[indexPath.row])
        return cell
    }
}
