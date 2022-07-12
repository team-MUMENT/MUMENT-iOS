//
//  DefaultTagListView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/12.
//
import UIKit
import SnapKit
import Then

class DefaultTagView: UIView {
    
    // MARK: - Properties
//    private let profileImage = UIImageView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
    }
}

// MARK: - UI
extension DefaultTagView {
    func setLayout() {
//        self.addSubviews([profileImage])
//
//        profileImage.snp.makeConstraints {
//            $0.left.top.equalTo(self.safeAreaLayoutGuide).inset(20)
//        }
    }
}

