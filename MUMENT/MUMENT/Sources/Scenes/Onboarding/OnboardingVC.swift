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
    private lazy var backgroundImageCV: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let pageControl: OnboardingPageControl = OnboardingPageControl().then {
        $0.currentPageIndicatorTintColor = .mPurple1
        $0.pageIndicatorTintColor = .mGray3
        $0.isUserInteractionEnabled = false
    }
    
    private let initiatingButton: MumentCompleteButton = MumentCompleteButton(isEnabled: false).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setBackgroundColor(.mBgwhite, for: .disabled)
        $0.setTitleColor(.mGray2, for: .disabled)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCV()
        setPageControl()
        setButtonActions()
    }
    
    // MARK: - Functions
    private func setCV() {
        backgroundImageCV.delegate = self
        backgroundImageCV.dataSource = self
        backgroundImageCV.register(OnboardingCVC.self, forCellWithReuseIdentifier: OnboardingCVC.className)
        backgroundImageCV.showsHorizontalScrollIndicator = false
        backgroundImageCV.isPagingEnabled = true
        backgroundImageCV.bounces = false
        
        CVFlowLayout.scrollDirection = .horizontal
        CVFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        CVFlowLayout.minimumInteritemSpacing = 0
    }
    
    private func setPageControl(){
        pageControl.numberOfPages = dataSource.count
    }
    
    private func setButtonActions() {
        initiatingButton.press {
            let signInVC = env() == .admin ? AdminSignInVC() : SignInVC()
            signInVC.modalPresentationStyle = .overFullScreen
            signInVC.modalTransitionStyle = .crossDissolve
            self.present(signInVC, animated: true)
        }
    }
}

// MARK: - UI
extension OnboardingVC {
    
    private func setLayout() {
        view.addSubviews([backgroundImageCV, pageControl, initiatingButton])
        
        backgroundImageCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        initiatingButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingVC: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        initiatingButton.isEnabled = pageControl.currentPage == dataSource.count - 1
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

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
