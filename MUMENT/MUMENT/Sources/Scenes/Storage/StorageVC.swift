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
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var segmentControl = UISegmentedControl().then {
        $0.selectedSegmentTintColor = .clear
        // 배경 색 제거
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        
        // Segment 구분 라인 제거
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        $0.insertSegment(withTitle: "나의 뮤멘트", at: 0, animated: true)
        $0.insertSegment(withTitle: "좋아요한 뮤멘트", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
        
        let headerTabFont = UIFont(name: "NotoSans-Bold", size: 16)!
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mGray1,
            NSAttributedString.Key.font: headerTabFont
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.mPurple1,
            NSAttributedString.Key.font: headerTabFont,
        ], for: .selected)
        
        $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    

    private let underLineView = UIView().then {
        $0.backgroundColor = .mPurple1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 움직일 underLineView의 leadingAnchor 따로 작성
    // 어떻게 snp, then 을 적용시키지..?
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderLayout()
        setSegmentLaysout()
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
}

// MARK: - UI
extension StorageVC {
    private func setHeaderLayout() {
        view.addSubviews([naviView, profileButton,containerView])
        
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

