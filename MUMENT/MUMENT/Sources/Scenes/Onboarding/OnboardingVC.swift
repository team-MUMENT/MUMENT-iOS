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
        setCV()
        pagingControl.numberOfPages = dataSource.count
    }
    
    // MARK: - Functions
    private func setCV() {
        CV.delegate = self
        CV.dataSource = self
        CV.register(OnboardingCVC.self, forCellWithReuseIdentifier: OnboardingCVC.className)
        CV.showsHorizontalScrollIndicator = false
        CV.isPagingEnabled = true
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagingControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
       }
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

extension OnboardingVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: CV.frame.width, height: CV.frame.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
