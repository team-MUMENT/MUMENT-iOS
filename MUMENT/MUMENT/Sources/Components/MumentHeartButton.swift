//
//  MumentHeartButton.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/21.
//

import UIKit
import Lottie

final class MumentHeartButton: UIButton {
    
    // MARK: Components
    private var animationView: LottieAnimationView = {
        let view: LottieAnimationView = LottieAnimationView(name: "heart_icn_lottie")
        view.isUserInteractionEnabled = false
        view.loopMode = .playOnce
        view.isHidden = true
        return view
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setLayout()
    }
    
    private func setUI() {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 5
        configuration.buttonSize = .small
        configuration.baseBackgroundColor = .clear
        self.configuration = configuration
    }
    
    private func playAnimation() {
        self.animationView.isHidden = false
        self.animationView.play()
        self.isUserInteractionEnabled = false
        self.animationView.animationSpeed = 1
        self.animationView.play(fromProgress: 0, toProgress: 1, loopMode: .none, completion: { [weak self] _ in
            self?.isUserInteractionEnabled = true
            self?.setImage(UIImage(named: "heart_filled"), for: .normal)
            self?.animationView.isHidden = true
        })
    }
    
    func setIsSelected(_ isSelected: Bool) {
        if isSelected {
            self.animationView.isHidden = true
            self.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            self.playAnimation()
        }
    }
    
    private func setLayout() {
        guard let heartImageView = self.imageView else { return }
        self.animationView.frame = heartImageView.frame
        self.animationView.frame.size.width = self.animationView.frame.size.width * 2.27
        self.animationView.frame.size.height = self.animationView.frame.size.height * 2.27
        self.animationView.center = heartImageView.center
        
        self.addSubview(animationView)
    }
}
