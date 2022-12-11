//
//  SearchBottomSheetVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/18.
//

import UIKit
import SnapKit
import Then

class SearchBottomSheetVC: BaseVC {
    
    // MARK: - Properties
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.mBgwhite
        $0.layer.cornerRadius = 11
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private let contentView = SearchForWriteView()
    private let containerHeight = NSLayoutConstraint()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
        self.setLayout()
    }
    
    // MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            self.hideBottomSheetWithAnimation()
        }
    }
    
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 700.adjustedH
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 0
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

// MARK: - UI
extension SearchBottomSheetVC {
    private func setUI() {
        self.view.backgroundColor = .mAlertBgBlack
        NotificationCenter.default.addObserver(self, selector: #selector(hideBottomSheetForReceived(_:)), name: .sendSearchResult, object: nil)
    }
    
    @objc func hideBottomSheetForReceived(_ notification: Notification){
        self.hideBottomSheetWithAnimation()
    }
    
    private func setLayout() {
        self.view.addSubViews([containerView])
        self.containerView.addSubviews([contentView])
        
        self.containerHeight.constant = 0
        self.containerView.snp.makeConstraints{
            $0.height.equalTo(containerHeight.constant)
            $0.width.equalTo(view.frame.width)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
