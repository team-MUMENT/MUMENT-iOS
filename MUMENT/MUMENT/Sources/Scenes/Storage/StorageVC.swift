//
//  StorageVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then

final class StorageVC: BaseVC {
    
    // MARK: - Components
    private let naviView = DefaultNavigationView().then {
        $0.backgroundColor = .clear
        $0.setTitleLabel(title: "보관함")
    }
    private let profileButton = UIButton().then {
        $0.makeRounded(cornerRadius: 30.adjustedH / 2)
    }
    private lazy var segmentContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let underLineBackGroundView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = .mPurple1
    }
    private lazy var pagerContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    private lazy var segmentControl = UISegmentedControl().then {
        $0.selectedSegmentTintColor = .clear
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        $0.insertSegment(withTitle: "나의 뮤멘트", at: 0, animated: true)
        $0.insertSegment(withTitle: "좋아요한 뮤멘트", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
                
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mGray1,
            NSAttributedString.Key.font: UIFont.mumentH4M16
        ], for: .normal)
        
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mPurple1,
            NSAttributedString.Key.font: UIFont.mumentH3B16,
        ], for: .selected)
        
        $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        $0.addTarget(self, action: #selector(didTapSegmentControl), for: .valueChanged)
    }
    
    // MARK: - Properties
    private var currentIndex: Int = 0
    private var isButtonTapped: Bool = false
    private let pagerVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let myMumentVC = StorageMumentVC(type: .myMument)
    private let likedMumentVC = StorageMumentVC(type: .likedMument)
    private lazy var contents: [UIViewController] = [
        self.myMumentVC,
        self.likedMumentVC
    ]
    /// 움직일 underLineView의 leadingAnchor 따로 작성
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    private var previousIndex = 0

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageViewController()
        setHeaderLayout()
        setSegmentLaysout()
        setPagerLayout()
        setPressAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabbar()
        self.setProfile()
        storageTabGA()
    }
    
    // MARK: - Function
    private func setPressAction() {
        profileButton.press {
            self.pushToMyPageMainVC()
        }
    }
    
    private func setPageViewController() {
        self.addChild(pagerVC)
        pagerContainerView.frame = pagerVC.view.frame
        self.pagerContainerView.addSubview(pagerVC.view)
        
        pagerVC.didMove(toParent: self)
        pagerVC.delegate = self
        pagerVC.dataSource = self
        
        if let firstVC = contents.first {
            pagerVC.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        for subView in pagerVC.view.subviews {
            if let scrollView = subView as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }

    @objc private func changeUnderLinePosition() {
        isButtonTapped = true
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.leadingDistance.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
    
    private func pushToMyPageMainVC() {
        let myPageVC = MypageMainVC()
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    @objc private func didTapSegmentControl() {
        let segmentIndex = segmentControl.selectedSegmentIndex
        storageTabGA(index: segmentIndex)
        if segmentIndex == 0 {
            myMumentVC.filterSectionView.listButton.sendActions(for: .touchUpInside)
            pagerVC.setViewControllers([contents[0]], direction: .reverse, animated: true)
        }else {
            likedMumentVC.filterSectionView.listButton.sendActions(for: .touchUpInside)
            pagerVC.setViewControllers([contents[1]], direction: .forward, animated: true)
        }
    }
    
    private func setProfile() {
        self.getUserProfile {
            UserInfo.shared.profileImageURL.getImage { image in
                DispatchQueue.main.async {
                    self.profileButton.setImage(image, for: .normal)
                    self.profileButton.imageView?.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
    private func storageTabGA(index: Int = 0) {
        if index == 0{
            sendGAEvent(eventName: .use_storage_tap, parameterValue: .click_storage_tap)
        } else {
            sendGAEvent(eventName: .use_storage_tap, parameterValue: .click_like_mument)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension StorageVC: UIPageViewControllerDataSource  {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return contents[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contents.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == contents.count {
            return nil
        }
        return contents[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension StorageVC: UIPageViewControllerDelegate {
    
    /// Paging 애니메이션이 끝났을 때 처리
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
              let index = contents.firstIndex(where: { $0 == viewController }) else {
                  return
              }
        currentIndex = index
        segmentControl.selectedSegmentIndex = currentIndex
        isButtonTapped = false
        
        if previousIndex != index {
            storageTabGA(index: index)
            previousIndex = index
        }
    }
}

extension StorageVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// 세그먼트로 이동시 종료
        guard !isButtonTapped else { return }
        
        let contentOffsetX = scrollView.contentOffset.x
        let contentWidth = pagerVC.view.frame.width
        /// 0 ~ 1의 값
        let offsetPercentage = (contentOffsetX - contentWidth) / contentWidth
        let constant = underLineView.frame.width * (CGFloat(currentIndex) + offsetPercentage)
        underLineView.frame.origin.x = constant
    }
}

// MARK: - UI
extension StorageVC {
    private func setHeaderLayout() {
        view.addSubviews([naviView, profileButton])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57.adjustedH)
        }
        
        profileButton.snp.makeConstraints{
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            $0.width.height.equalTo(30.adjustedH)
        }
    }
    
    private func setSegmentLaysout() {
        view.addSubviews([segmentContainerView])
        
        segmentContainerView.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50.adjustedH)
        }
        
        segmentContainerView.addSubViews([segmentControl,underLineBackGroundView, underLineView])
        
        segmentControl.snp.makeConstraints{
            $0.top.leading.centerX.centerY.equalTo(segmentContainerView)
        }
        
        underLineBackGroundView.snp.makeConstraints {
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.height.equalTo(2)
            $0.width.equalTo(segmentControl.snp.width)
        }
        
        underLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.height.equalTo(2)
            $0.width.equalTo(segmentControl.snp.width).dividedBy(segmentControl.numberOfSegments)
            
        }
        NSLayoutConstraint.activate([leadingDistance])
    }
    
    private func setPagerLayout() {
        view.addSubviews([pagerContainerView])
        pagerContainerView.snp.makeConstraints{
            $0.top.equalTo(segmentContainerView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)  
        }
    }
    
}
