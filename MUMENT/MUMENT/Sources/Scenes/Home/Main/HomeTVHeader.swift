//
//  HeaderTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//

import UIKit
import SnapKit
import Then

class HomeTVHeader: UIView {
    
    // MARK: - Properties
    private lazy var logoButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentLogo"), for: .normal)
    }
    
    private lazy var notificationButton = UIButton().then{
        $0.setImage(UIImage(named: "mumentNoti"), for: .normal)
    }
    
    private lazy var searchButton = MumentSearchBarButton(type: .system)
    
    private let headerCoverView = UIView().then{
        $0.backgroundColor = .mBgwhite
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Function
    func setButtonAction(vc: UIViewController, function: @escaping ()->Void ) {
        searchButton.press{
            let searchVC = SearchVC()
            vc.navigationController?.pushViewController(searchVC, animated: true) {
                if UserInfo.shared.isFirstVisit {
                    sendGAEvent(eventName: .first_visit_page, parameterValue: .direct_search)
                    UserInfo.shared.isFirstVisit = false
                }
                sendGAEvent(eventName: .home_activity_type, parameterValue: .home_search)
            }
        }
        
        notificationButton.press {
            let notificationVC = NotificationVC()
            vc.navigationController?.pushViewController(notificationVC, animated: true)
        }
        
        logoButton.press {
            function()
        }
    }
    
    func setButtonAlpha(percentage: CGFloat) {
        logoButton.alpha = percentage
        notificationButton.alpha = percentage
    }
    
    func setNotificationButtonIcon(isNew: Bool) {
        self.notificationButton.setImage(UIImage(named: isNew ? "mumentNotiRed" : "mumentNoti"), for: .normal)
    }
}

// MARK: - UI
extension HomeTVHeader {
    
    private func setLayout() {
        self.addSubviews([logoButton,notificationButton,searchButton])
        self.backgroundColor = .mBgwhite
        
        searchButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        logoButton.snp.makeConstraints{
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.width.equalTo(132)
            $0.height.equalTo(30)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(60)
        }
        
        notificationButton.snp.makeConstraints{
            $0.width.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(55)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(13)
        }
    }
}
