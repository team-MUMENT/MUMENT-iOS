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
        $0.textContainerInset = .zero
        $0.contentInset = .zero
        $0.textContainer.lineFragmentPadding = 0
        $0.dataDetectorTypes = .link
    }
    
    // MARK: Properties
    private var noticeData: GetNoticeListResponseModelElement = GetNoticeListResponseModelElement(id: 0, title: "", content: "", createdAt: "")
    private var noticeId: Int = 0
    
    // MARK: Initialization
    init(noticeId: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.noticeId = noticeId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackButton()
        self.setContentTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getNoticeDetail(noticeId: self.noticeId)
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
        self.titleView.setData(data: GetNoticeListResponseModelElement(id: self.noticeId, title: self.noticeData.title, content: self.noticeData.content, createdAt: self.noticeData.createdAt))
    }
    
    private func setContent() {
        self.contentTextView.text = self.noticeData.content
    }
}

// MARK: - Network
extension MypageNoticeDetailVC {
    private func getNoticeDetail(noticeId: Int) {
        self.startActivityIndicator()
        MyPageAPI.shared.getNoticeDetail(noticeId: noticeId) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetNoticeListResponseModelElement {
                    self.noticeData = result
                    self.setTitleView()
                    self.setContent()
                    self.setLayout()
                }
                self.stopActivityIndicator()
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
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
            $0.top.equalTo(self.naviView.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.contentTextView.snp.makeConstraints {
            $0.top.equalTo(self.titleView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}

extension MypageNoticeDetailVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.openSafariVC(url: URL)
        return false
    }
}
