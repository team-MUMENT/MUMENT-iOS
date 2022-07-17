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
        $0.backgroundColor = .clear
        $0.setTitleLabel(title: "보관함")
    }
    
    private let profileButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentStorageProfile"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var segmentContainerView = UIView().then {
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
            NSAttributedString.Key.font: UIFont.mumentH3B16
        ], for: .normal)
        
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mPurple1,
            NSAttributedString.Key.font: UIFont.mumentH3B16,
        ], for: .selected)
        
        $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        $0.addTarget(self, action: #selector(didTapSegmentControl), for: .valueChanged)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = .mPurple1
    }
    
    /// 움직일 underLineView의 leadingAnchor 따로 작성
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    
    private lazy var tagsViewHeight: NSLayoutConstraint = {
        return selectedTagsView.heightAnchor.constraint(
            equalToConstant: CGFloat(tagsViewHeightConstant)
        )
    }()
    
    private lazy var filterSectionContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let filterButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentFilterOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentFilterOn"), for: .selected)
        $0.contentMode = .scaleAspectFit
    }
    
    private let storageBottomSheet = StorageBottomSheet()
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 15
    }
    
    private let albumButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentAlbumOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentAlbumOn"), for: .selected)
        $0.contentMode = .scaleAspectFit
    }
    
    private let listButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentListOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentListOn"), for: .selected)
        $0.isSelected = true
        $0.contentMode = .scaleAspectFit
    }
    
    private let selectedTagsView = UIView().then {
        $0.backgroundColor = UIColor.mGray5
    }
    
    var tagsViewHeightConstant = 0
    
    private let pagerVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

    private let myMumentVC = MyMumentVC()
    private let likedMumentVC = LikedMumentVC()
    
    private lazy var contents: [UIViewController] = [
        self.myMumentVC,
        self.likedMumentVC
    ]
    
    private var currentIndex: Int = 0
    
    private lazy var pagerContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageViewController()
        setHeaderLayout()
        setSegmentLaysout()
        setFilterSectionLayout()
        setTagsViewLayout()
        setPagerLayout()
        
        setPressAction()
    }
    
    // MARK: - Function
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
    
    private func setPressAction() {
        filterButton.press {
            self.filterButton.isSelected.toggle()
            
//            self.tagsViewHeightConstant = self.filterButton.isSelected ? 49 : 0
//
//            self.selectedTagsView.snp.updateConstraints {
//                $0.height.equalTo(self.tagsViewHeightConstant)
//            }
            
            if self.filterButton.isSelected {
                self.storageBottomSheet.modalTransitionStyle = .crossDissolve
                self.storageBottomSheet.modalPresentationStyle = .overFullScreen
                self.present(self.storageBottomSheet, animated: false) {
                    self.storageBottomSheet.showBottomSheetWithAnimation()
                }
            }else {
                self.present(self.storageBottomSheet, animated: false) {
                    self.storageBottomSheet.hideBottomSheetWithAnimation()
                }            }
            
        }
        
        listButton.press {
            self.listButton.isSelected = true
            self.albumButton.isSelected = false

            if self.segmentControl.selectedSegmentIndex == 0 {
                self.myMumentVC.cellCategory = .listCell
            }else {
                self.likedMumentVC.cellCategory = .listCell
            }
            
        }
        
        albumButton.press {
            self.albumButton.isSelected = true
            self.listButton.isSelected = false

            if self.segmentControl.selectedSegmentIndex == 0 {
                self.myMumentVC.cellCategory = .albumCell
            }else {
                self.likedMumentVC.cellCategory = .albumCell
            }
        }
    }
    
    @objc private func didTapSegmentControl() {
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
            
        if segmentIndex == 0 {
            listButton.sendActions(for: .touchUpInside)
            pagerVC.setViewControllers([contents[0]], direction: .reverse, animated: true)
        }else {
            listButton.sendActions(for: .touchUpInside)
            pagerVC.setViewControllers([contents[1]], direction: .forward, animated: true)
        }
    }
}

// MARK: - UIPageVC
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

extension StorageVC: UIPageViewControllerDelegate {
    
    /// Paging 애니메이션이 끝났을 때 처리
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
              let index = contents.firstIndex(where: { $0 == viewController }) else {
                  return
              }
        currentIndex = index
        segmentControl.selectedSegmentIndex = currentIndex
        changeUnderLinePosition()
    }
}

// MARK: - Set Layout
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
        
        segmentContainerView.addSubViews([segmentControl,underLineView])
        
        segmentControl.snp.makeConstraints{
            $0.top.leading.centerX.centerY.equalTo(segmentContainerView)
        }
        
        underLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.height.equalTo(2.adjustedH)
            $0.width.equalTo(segmentControl.snp.width).dividedBy(segmentControl.numberOfSegments)
            
        }
        
        NSLayoutConstraint.activate([leadingDistance])
    }
    
    private func setFilterSectionLayout() {
        view.addSubviews([filterSectionContainerView, selectedTagsView])
        
        filterSectionContainerView.snp.makeConstraints{
            $0.top.equalTo(segmentContainerView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        filterSectionContainerView.addSubViews([filterButton, buttonStackView])
        
        filterButton.snp.makeConstraints{
            $0.top.equalTo(filterSectionContainerView).inset(12)
            $0.leading.equalTo(filterSectionContainerView).inset(20)
            $0.bottom.equalTo(filterSectionContainerView).inset(12)
        }
        
        [albumButton, listButton].forEach {
            self.buttonStackView.addArrangedSubview($0)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.bottom.equalTo(filterSectionContainerView).inset(12)
            $0.trailing.equalTo(filterSectionContainerView).inset(20)
            $0.width.equalTo(55)
        }
        
    }
    
    private func setTagsViewLayout() {
        ///필터 구현시까지 높이 0으로 처리
        selectedTagsView.snp.makeConstraints{
            $0.top.equalTo(filterSectionContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.tagsViewHeightConstant)
        }
        
        NSLayoutConstraint.activate([leadingDistance])
    }
    
    private func setPagerLayout() {
        view.addSubviews([pagerContainerView])
        pagerContainerView.snp.makeConstraints{
            $0.top.equalTo(selectedTagsView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)  
        }
    }
    
}
