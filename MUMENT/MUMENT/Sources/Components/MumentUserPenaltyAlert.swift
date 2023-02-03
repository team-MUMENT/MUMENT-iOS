//
//  MumentUserPenaltyAlert.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/04.
//

import UIKit
import SnapKit

final class MumentUserPenaltyAlert: BaseVC {
    
    // MARK: - Properties
    private let alertView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .mWhite
        view.makeRounded(cornerRadius: 11.adjustedH)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "서비스 이용 제한 안내"
        label.font = .mumentH3B16
        label.textColor = .mBlack2
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "서비스 운영정책 위반으로\n뮤멘트 작성이 제한되었습니다.\n\n자세한 내용은 고객 센터에 문의해주세요.\n[마이페이지]-[문의하기]"
        label.numberOfLines = 5
        label.font = .mumentB8M12
        label.textColor = .mBlack2
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let reasonTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "제재이유"
        label.font = .mumentB7B12 // TODO: 디자인 확인 필요
        label.textColor = .mBlack2
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let reasonContentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .mumentB8M12 // TODO: 디자인 확인 필요
        label.textColor = .mBlack2
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private let endDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "제재기간"
        label.font = .mumentB7B12 // TODO: 디자인 확인 필요
        label.textColor = .mBlack2
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let endDateContentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .mumentB8M12 // TODO: 디자인 확인 필요
        label.textColor = .mBlack2
        label.textAlignment = .center
        return label
    }()
    
    private var OKButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitleWithCustom("확인", font: .mumentB4M14, color: .mPurple1, for: .normal)
        return button
    }()
    
    // MARK: Properties
    private var penaltyData: GetUserPenaltyResponseModel?
    
    // MARK: Initialization
    init(penaltyData: GetUserPenaltyResponseModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.penaltyData = penaltyData
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
        self.setLayout()
    }
    
    // MARK: Methods
    private func setData() {
        if let data: GetUserPenaltyResponseModel = self.penaltyData {
            let reasonMusicString: String = "\(data.musicArtist ?? "") - \(data.musicTitle ?? "")"
            
            self.reasonContentLabel.text = "\(data.reason ?? "")\n\(reasonMusicString)"
            self.reasonContentLabel.setFontColor(to: reasonMusicString, font: .mumentB7B12, color: .mPurple1) // TODO: font, color 디자인 확인 필요
            self.endDateContentLabel.text = "\(data.endDate ?? "")까지 \(data.period ?? "")"
            
            self.reasonContentLabel.sizeToFit()
            self.endDateContentLabel.sizeToFit()
        }
    }
    
    private func setOKButtonAction() {
        self.OKButton.press { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - UI
extension MumentUserPenaltyAlert {
    private func setUI() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = .mAlertBgBlack
    }
    
    private func setLayout() {
        self.setDefaultLayout()
        self.setContentLayout()
    }
    
    private func setDefaultLayout() {
        self.view.addSubviews([alertView])
        
        self.alertView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(53.adjustedW)
            make.center.equalToSuperview()
        }
    }
    
    private func setContentLayout() {
        self.alertView.addSubviews([titleLabel, contentLabel, reasonTitleLabel, reasonContentLabel, endDateTitleLabel, endDateContentLabel, OKButton])
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30.adjustedH)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.reasonTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.reasonContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.reasonTitleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.endDateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.reasonContentLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.endDateContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.endDateTitleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.OKButton.snp.makeConstraints { make in
            make.top.equalTo(self.endDateContentLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.titleLabel)
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
    }
}
