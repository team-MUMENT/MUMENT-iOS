//
//  OrderingButton.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/16.
//
import UIKit

class OrderingButton: UIButton {
    private var buttonText = ""
    private func setConfiguration(){
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .small
        configuration.baseBackgroundColor = UIColor.mBgwhite
        self.configuration = configuration
    }
    
    private func setTextStyle(){
        self.setAttributedTitle(NSAttributedString(string: buttonText, attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mPurple1
        ]), for: .selected)
        self.setAttributedTitle(NSAttributedString(string: buttonText, attributes: [
            .font: UIFont.mumentC1R12,
            .foregroundColor: UIColor.mGray1
        ]), for: .normal)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init(_ text:String) {
        super.init(frame:CGRect.zero)
        buttonText = text
        setConfiguration()
        setTextStyle()
    }
}

