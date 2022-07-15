//
//  AlbumCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/16.
//

import UIKit

class AlbumCVC: UICollectionViewCell {
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    private let IDLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - Function
    private func setUI() {
        self.addSubviews([imageView, IDLabel])
        self.backgroundColor = .blue
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
        
        IDLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setData() {
        imageView.image = UIImage(named: "image2")
        IDLabel.text = "testtest"
    }
}
