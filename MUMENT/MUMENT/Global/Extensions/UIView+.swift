//
//  UIView+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/07.
//

import UIKit

enum VerticalLocation {
    case bottom
    case top
    case left
    case right
    case bottomRight
    case nadoBotttom
}

extension UIView {
    @discardableResult
    func makeShadow(color: UIColor,
                    opacity: Float,
                    offset: CGSize,
                    radius: CGFloat) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func setGradient(colors: [CGColor],
                     locations: [NSNumber] = [0.0, 1.0],
                     startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
                     endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) -> Self {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        layer.addSublayer(gradient)
        return self
    }
    
    func addSubView<T: UIView>(_ subview: T, completionHandler closure: ((T) -> Void)? = nil) {
        addSubview(subview)
        closure?(subview)
    }
    
    func addSubViews<T: UIView>(_ subviews: [T], completionHandler closure: (([T]) -> Void)? = nil) {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func addShadow(location: VerticalLocation, color: UIColor = .gray, opacity: Float = 0.2, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -4), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -10, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 10, height: 0), color: color, opacity: opacity, radius: radius)
        case .bottomRight:
            addShadow(offset: CGSize(width: 3, height: 3), color: color, opacity: opacity, radius: radius)
        case .nadoBotttom:
            addShadow(offset: CGSize(width: 0, height: 4), color: color, opacity: opacity, radius: radius)
        }
        
    }
    
    /// UIView의 그림자를 설정하는 메서드
    func addShadow(offset: CGSize, color: UIColor = .mGray1, opacity: Float = 0.07, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    /// UIView 의 모서리가 둥근 정도를 설정하는 메서드
    func makeRounded(cornerRadius : CGFloat?) {
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    /// UIView 의 모서리가 둥근 정도를 방향과 함께 설정하는 메서드
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// 진동 온 것처럼 흔들리게 하는 메서드
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-5.0, 5.0, -5.0, 5.0 ,-2.0, 2.0, 0.0 ]
        self.layer.add(animation, forKey: "shake")
    }
    
    /**
     - Description:
     VC나 View 내에서 해당 함수를 호출하면, 햅틱이 발생하는 메서드입니다.
     버튼을 누르거나 유저에게 특정 행동이 발생했다는 것을 알려주기 위해 다음과 같은 햅틱을 활용합니다.
     
     - parameters:
     - degree: 터치의 세기 정도를 정의. 보통은 medium,light를 제일 많이 활용합니다.
     */
    func makeVibrate(degree : UIImpactFeedbackGenerator.FeedbackStyle = .medium)
    {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
    
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
            defer {
                UIGraphicsEndImageContext()
            }
            if let context = UIGraphicsGetCurrentContext() {
                layer.render(in: context)
                return UIGraphicsGetImageFromCurrentImageContext()
            }
            return nil
        }
    
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
//        let view = contorller.view
//        let targetSize = controller.view?.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let render = UIGraphicsImageRenderer(size: targetSize)
//
//        return render.image {_ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
    func asImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
        print("BOUNDS",bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
