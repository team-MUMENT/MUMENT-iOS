//
//  selectedTagButton.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/19.
//
import UIKit

class TagButton: UIButton {
    
    override init(frame: CGRect){
       super.init(frame: frame)
   }
        
    init() {
        super.init(frame:CGRect.zero)
        self.backgroundColor = .mBlue3
        self.makeRounded(cornerRadius: 17)
        self.setImage(UIImage(named: "mumentTagDelete"), for: .normal)
        self.contentHorizontalAlignment = .center
        self.configuration = .plain()
        self.configuration?.imagePadding = 5.adjustedH
        self.configuration?.imagePlacement = .trailing
        self.attributedTitle(for: .normal)
    }
    
    func setTagButtonTitle(_ title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mumentB2B14,
            .foregroundColor: UIColor.mBlue1
        ]
        self.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
