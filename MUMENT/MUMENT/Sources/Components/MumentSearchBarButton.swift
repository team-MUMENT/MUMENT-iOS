//
//  MumentSearchBarButton.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/06.
//

import UIKit

final class MumentSearchBarButton: UIButton {
    
    // MARK: Components
    private let textField: MumentSearchTextField = {
        let textField: MumentSearchTextField = MumentSearchTextField()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setLayout()
        self.setBackgroundColor(.mGray4, for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension MumentSearchBarButton {
    private func setUI() {
        self.textField.placeholder = "어떤 노래가 궁금하신가요?"
    }
    
    private func setLayout() {
        self.addSubview(textField)
        
        self.textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
