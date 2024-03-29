//
//  UIButton+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

extension UIButton {
    
    /// 버튼 Background Color를 상태별로 지정하는 메서드
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(minimumSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: minimumSize))
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: state)
    }
    
    /// 버튼의 Title을 Font, Color와 함께 상태별로 지정하는 메서드. 상태가 여러 개 필요할 경우, 각각의 상태에 모두 title과 font, color를 지정해 주어야 함.
    func setTitleWithCustom(_ title: String, font: UIFont?, color: UIColor?, for state: UIControl.State) {
        self.setAttributedTitle(NSAttributedString(string: title, attributes: [.font: font ?? UIFont(), .foregroundColor: color ?? .mBlack1]), for: state)
    }
    
    /// button의 기본, 클릭 이미지를 빠르게 설정하는 메서드
    func setImgByName(name: String, selectedName: String?) {
        self.setImage(UIImage(named: name), for: .normal)
        if let selected = selectedName {
            self.setImage(UIImage(named: selected), for: .selected)
        }
    }
    
    /**
     button에 대해 addTarget해서 일일이 처리안하고, closure 형태로 동작을 처리하기 위해 다음과 같은 extension을 활용합니다
     press를 작성하고, 안에 버튼이 눌렸을 때, 동작하는 함수를 만듭니다.
     
     clicked(completion : @escaping ((Bool) -> Void)) 함수를 활용해,
     버튼이 눌렸을때, 줄어들었다가 다시 늘어나는 (Popping)효과를 추가해서
     사용자에게 버튼이 눌렸다는 인터렉션을 제공합니다!
     
     진동은 선택 가능하게 바꾸었습니다.
     
     iOS14부터는 UIAction의 addAction이 가능
     iOS13까지는 NSObject형태로 등록해서 처리하는 방식으로 분기처리합니다.
     */
    func press(vibrate: Bool = false, for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        if #available(iOS 14.0, *) {
            self.addAction(UIAction { (action: UIAction) in closure()
                self.clickedAnimation(vibrate: vibrate)
            }, for: controlEvents)
        } else {
            @objc class ClosureSleeve: NSObject {
                let closure:()->()
                init(_ closure: @escaping()->()) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            self.addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /**
     해당 함수를 통해서 Poppin 효과를 처리합니다.
     - Description:
     줄어드는 정도를 조절하고싶다면 ,ScaleX,Y값을 조절합니다(최대값 1).
     낮을수록 많이 줄어듦.
     */
    func clickedAnimation(vibrate: Bool) {
        if vibrate { makeVibrate(degree: .light) }
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) }, completion: { (finish: Bool) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        )
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
