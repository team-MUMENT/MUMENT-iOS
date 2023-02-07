//
//  ReportMumentCategoryFooter.swift
//  MUMENT
//
//  Created by 김담인 on 2023/02/06.
//

import UIKit
import SnapKit
import Then

protocol sendTextViewDelegate: AnyObject {
    func sendTextViewState(isEditing: Bool)
    func sendReportContent(content: String)
}

final class ReportMumentFooter: UITableViewHeaderFooterView {
    
    // MARK: - Components
    private let contentTextView = UITextView().then {
        $0.isScrollEnabled = false
        $0.clipsToBounds = true
        $0.backgroundColor = .mGray5
        $0.font = .mumentB6M13
        $0.text = "계정을 삭제하는 이유를 알려주세요."
        $0.textColor = .mGray1
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 13, bottom: 15, right: 13)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        $0.autocapitalizationType = .none
    }
    
    private let placeholder = "계정을 삭제하는 이유를 알려주세요."
    
    private let countTextViewLabel = UILabel().then {
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.text = "0/100"
    }
    
    private var textCount: String = " " {
        didSet {
            let highlighttedString = NSAttributedString(string: textCount, attributes: [
                .font: UIFont.mumentB6M13,
                .foregroundColor: UIColor.mPurple1
            ])
            
            let normalString = NSAttributedString(string: " / 100", attributes: [
                .font: UIFont.mumentB6M13,
                .foregroundColor: UIColor.mGray2
            ])
            
            let title = highlighttedString + normalString
            countTextViewLabel.attributedText = title
        }
    }
    
    weak var delegate: sendTextViewDelegate?
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setTextView() {
        contentTextView.makeRounded(cornerRadius: 7)
        contentTextView.delegate = self
        contentTextView.isEditable = false
    }
    
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
}

extension ReportMumentFooter: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.sendTextViewState(isEditing: true)
        
        /// 플레이스홀더
        if contentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            contentTextView.textColor = .mGray1
            contentTextView.text = placeholder
        } else if textView.text == placeholder {
            contentTextView.textColor = .mBlack1
            contentTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.sendTextViewState(isEditing: false)
        
        // 플레이스홀더
        if contentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            contentTextView.textColor = .mGray1
            contentTextView.text = placeholder
            countTextViewLabel.text = "0/100"
        }
        
        self.delegate?.sendReportContent(content: contentTextView.text)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /// 글자 수 제한
        if contentTextView.text.count > 100 {
            contentTextView.deleteBackward()
        }
        
        textCount = "\(contentTextView.text.count)"
    }
}

extension ReportMumentFooter: reportMumentDelegate {
    func sendIsEtcSelected(isSelected: Bool) {
        self.contentTextView.isEditable = isSelected
    }
}