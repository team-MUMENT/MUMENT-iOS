//
//  UILabel+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

extension UILabel {
    func addLabelSpacing(kernValue: Double = -0.6, lineSpacing: CGFloat = 4.0) {
        if let labelText = self.text, labelText.count > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributedText = NSAttributedString(string: labelText,
                                                attributes: [.kern: kernValue,
                                                             .paragraphStyle: paragraphStyle])
            lineBreakStrategy = .hangulWordPriority
        }
    }
    
    func setColor(to targetString: String, with color: UIColor) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.foregroundColor,
                                          value: color,
                                          range: (labelText as NSString).range(of: targetString))
            attributedText = attributedString
        }
    }
    
    func setFont(to targetString: String, with font: UIFont) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.font,
                                          value: font,
                                          range: (labelText as NSString).range(of: targetString))
            attributedText = attributedString
        }
    }
    
    func setHyperlinkedStyle(to targetStrings: [String]) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let linkAttributes : [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.mumentB7B12
            ]
            for targetString in targetStrings{
                attributedString.setAttributes(
                    linkAttributes,
                    range: (labelText as NSString).range(of: targetString))
            }
            
            attributedText = attributedString
        }
    }
    
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat){
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
    
    /// 글씨의 오토레이아웃이 기본으로 되어있는 메서드
    func setLabel(text: String, color: UIColor = .mBlack1, font: UIFont) {
        self.font = font
        self.textColor = color
        self.text = text
    }
}
