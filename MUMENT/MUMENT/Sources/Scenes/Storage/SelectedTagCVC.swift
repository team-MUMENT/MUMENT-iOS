//
//  SelectedTagCVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/01/26.
//

import UIKit
import SnapKit
import Then

final class SelectedTagCVC: UICollectionViewCell {
    
    private let contentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .mumentB2B14
        $0.textColor = .mBlue1
    }
    private let tagDeleteImage = UIImageView().then {
        $0.image = UIImage(named: "mumentTagDelete")
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTagButtonTitle(_ title: String) {
        contentLabel.text = title
        contentLabel.sizeToFit()
        self.contentView.layoutIfNeeded()
        self.contentView.layoutSubviews()
//        self.contentView.frame = self.bounds
    }
}


// MARK: - UI
extension SelectedTagCVC {
    private func setUI() {
        contentView.backgroundColor = .mBlue3
        contentView.makeRounded(cornerRadius: 17)
    }
    
    private func setLayout() {
        contentView.addSubviews([contentLabel, tagDeleteImage])
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(11)
        }
        
        tagDeleteImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(contentLabel.snp.right).offset(5)
            $0.width.height.equalTo(17)
        }
    }
}

//    private let selectedTagButton = TagButton()
//
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setTagButtonTitle(_ title: String) {
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.mumentB2B14,
//            .foregroundColor: UIColor.mBlue1
//        ]
//        selectedTagButton.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: .normal)
//        selectedTagButton.titleLabel?.sizeToFit()
//    }
//}
//
//// MARK: - UI
//extension SelectedTagCVC {
//    private func setLayout() {
//        contentView.addSubview(selectedTagButton)
//
//        selectedTagButton.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//}
