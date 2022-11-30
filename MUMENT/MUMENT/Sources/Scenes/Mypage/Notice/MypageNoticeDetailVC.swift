//
//  MypageNoticeDetailVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/12/01.
//

import UIKit
import Then
import SnapKit

final class MypageNoticeDetailVC: BaseVC {
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrow).then {
        $0.setTitleLabel(title: "공지사항")
    }
    
    private let titleView: MypageNoticeTitleView = MypageNoticeTitleView()
    private let contentTextView: UITextView = UITextView().then {
        $0.font = .mumentB4M14
        $0.textColor = .mBlack2
        $0.backgroundColor = .mBgwhite
        $0.isEditable = false
        $0.contentInset = .zero
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        $0.dataDetectorTypes = .link
    }
    
    // MARK: Properties
    private var noticeData: GetNoticeResponseModel = GetNoticeResponseModel(title: "게시물 이름 1", createdAt: "2022.10.18", content: String(repeating: "https://www.github.com ", count: 200))
    private var noticeId: String = ""
    
    // MARK: Initialization
    init(noticeId: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.noticeId = noticeId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButton()
        self.setContentTextView()
        self.setTitleView()
        self.setContent()
    }
    
    // MARK: Methods
    private func setBackButton() {
        self.naviView.backButton.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setContentTextView() {
        self.contentTextView.delegate = self
    }
    
    private func setTitleView() {
        self.titleView.setData(data: GetNoticeListResponseModelElement(id: self.noticeId, title: self.noticeData.title, createdAt: self.noticeData.createdAt))
    }
    
    private func setContent() {
        self.contentTextView.text = self.noticeData.content
    }
}

// MARK: - UI
extension MypageNoticeDetailVC {
    private func setLayout() {
        self.view.addSubviews([naviView, titleView, contentTextView])
        
        self.naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        self.titleView.snp.makeConstraints {
            $0.top.equalTo(self.naviView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(89)
        }
        
        self.contentTextView.snp.makeConstraints {
            $0.top.equalTo(self.titleView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MypageNoticeDetailVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.openSafariVC(url: URL)
        return false
    }
}
