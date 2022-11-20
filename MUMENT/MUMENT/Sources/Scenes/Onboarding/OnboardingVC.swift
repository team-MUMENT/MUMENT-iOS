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
    private let CVFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var dataSource: [OnboardingModel] = OnboardingModel.onboardingData
    
    // MARK: - Components
    private lazy var CV: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let pageControl: UIPageControl = UIPageControl().then {
        $0.currentPageIndicatorTintColor = .mPurple1
        $0.pageIndicatorTintColor = .mGray3
        $0.isUserInteractionEnabled = false
//        $0.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }
    
    private let initiatingButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setBackgroundColor(.mBgwhite, for: .disabled)
        $0.setTitleColor(.mGray2, for: .normal)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCV()
        setPageControl()
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
    
    private func setPageControl(){
        pageControl.numberOfPages = dataSource.count
    }
}

// MARK: - UI
extension OnboardingVC {
    
    private func setLayout() {
        view.addSubviews([CV,pageControl,initiatingButton])
        
        CV.snp.makeConstraints {
//            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
            $0.centerX.equalToSuperview()
        }
        
        initiatingButton.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingVC: UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
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
