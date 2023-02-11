//
//  MumentActivityIndicatorView.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/11.
//

import UIKit

final class MumentActivityIndicatorView: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.color = .mPurple1
        self.hidesWhenStopped = true
        self.style = .medium
        self.stopAnimating()
    }
}
