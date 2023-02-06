//
//  ReportMumentCategoryFooter.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

final class ReportMumentFooter: UITableViewHeaderFooterView {
    
    // MARK: - Components
    private let contentTextView = UITextView().then {
        $0.isScrollEnabled = false
        $0.clipsToBounds = true
        $0.backgroundColor = .mGray5
        $0.font = .mumentB3M14
        $0.text = "계정을 삭제하는 이유를 알려주세요."
        $0.textColor = .mBlack2
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 13, bottom: 15, right: 13)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        $0.autocapitalizationType = .none
    }
    private let countTextViewLabel = UILabel().then {
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.text = "0/100"
    }
    
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        contentTextView.makeRounded(cornerRadius: 7)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setLayout() {
        self.addSubviews([contentTextView, countTextViewLabel])
        
        contentTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-13)
        }
        
        countTextViewLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentTextView).offset(-15)
            $0.right.equalTo(contentTextView).inset(11)
        }
    }
    
    func setTextViewDelegate(vc: UIViewController) {
        contentTextView.delegate = vc as? any UITextViewDelegate
    }
    
}

//extension ReportMumentFooter: UITextViewDelegate {
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if contentTextView.textColor == UIColor.mGray1 {
//            contentTextView.text = ""
//            contentTextView.textColor = .mBlack2
//        }
////    TODO: 델리게이트로 알려주기
////        self.view.frame.origin.y = -280
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if contentTextView.text.isEmpty {
//            contentTextView.text =  "계정을 삭제하는 이유를 알려주세요."
//            contentTextView.textColor = .mGray1
//        }
//
////        self.view.frame.origin.y = 0
//    }
//}
