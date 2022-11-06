//
//  AutoSignInVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit
import SnapKit
import Then

class AutoSignInVC: UIViewController {
    
    // MARK: - Properties
    private let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "mumentIcon")
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            
            // TODO: - 자동 로그인 되었을 시 아래 코드 수행되도록
            let tabBarControlller = MumentTabBarController()
            tabBarControlller.modalPresentationStyle = .fullScreen
            tabBarControlller.modalTransitionStyle = .crossDissolve
            self.present(tabBarControlller, animated: true)
        }
    }
}

// MARK: - UI
extension AutoSignInVC {
    
    private func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "splashBackground")
        backgroundImageView.contentMode = .scaleAspectFit
        self.view.addSubview(backgroundImageView)
    }
    
    private func setLayout() {
        view.addSubviews([logoImageView])
        
        logoImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(295)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
