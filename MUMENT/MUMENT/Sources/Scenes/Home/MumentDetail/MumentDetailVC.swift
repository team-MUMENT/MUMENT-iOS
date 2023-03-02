//
//  MumentDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MumentDetailVC: BaseVC, UIActionSheetDelegate {
    
    // MARK: - Components
    private let navigationBarView = DefaultNavigationBar()
    private let detailScrollView = UIScrollView()
    private let detailContentView = UIView().then {
        $0.backgroundColor = .mBgwhite
    }
    private let mumentCardView = DetailMumentCardView()
    private let historyButton = UIButton().then {
        $0.makeRounded(cornerRadius: 11)
        $0.setBackgroundImage(UIImage(named:"history_btn"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.contentHorizontalAlignment = .left
    }
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.mumentC1R12,
        .foregroundColor: UIColor.mGray1
    ]
    
    // MARK: - Properties
    private let instagramShareView = InstagramShareView()
    private var historyButtonText: String = "" {
        didSet{
            historyButton.setAttributedTitle(NSAttributedString(string: historyButtonText,attributes: attributes), for: .normal)
        }
    }
    private var mumentId = 0
    private var userId = 0
    private var musicData: MusicDTO = MusicDTO(id: "", title: "", artist: "", albumUrl: "")
    private var dataSource: MumentDetailResponseModel?
    private let myMumentActionSheetVC = MumentActionSheetVC(actionName: ["수정하기", "삭제하기"])
    private let othersMumentActionSheetVC = MumentActionSheetVC(actionName: ["뮤멘트 신고하기", "유저 차단하기"])
    private var reportCategory: [Int] = [3, 4]
    private var reportContent: String = ""
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setClickEventHandlers()
        mumentCardView.setDelegate(delegate: self)
        self.setMyMumentMenuActionSheet()
        self.setOthersMumentActionSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabbar()
        requestGetMumentDetail()
        sendMumentDetailGAEvent()
    }
    
    // MARK: - Functions
    func setData(){
        DispatchQueue.main.async {
            self.navigationBarView.setTitle("뮤멘트")
            self.mumentCardView.setData(self.dataSource ?? MumentDetailResponseModel(isFirst: false, content: "", impressionTag: [], isLiked: false, count: 0, likeCount: 0, createdAt: "", feelingTag: [], user: MUMENT.MumentDetailResponseModel.User(id: 0, image: Optional(""), name: ""), isPrivate: false), self.musicData, self.mumentId)
            self.historyButtonText = "     \(self.dataSource?.count ?? 0)개의 뮤멘트가 있는 히스토리 보러가기"
        }
    }
    
    func setData(mumentId: Int, musicData: MusicDTO) {
        self.mumentId = mumentId
        self.musicData = musicData
    }
    
    private func setClickEventHandlers() {
        navigationBarView.backButton.press {
            self.navigationController?.popViewController(animated: true)
        }
        
        historyButton.press {
            let mumentHistoryVC = MumentHistoryVC()
            mumentHistoryVC.setHistoryData(userId: self.userId, musicData: self.musicData)
            self.navigationController?.pushViewController(mumentHistoryVC, animated: true) {
                if UserDefaultsManager.userId == self.userId {
                    sendGAEvent(eventName: .mument_history_view, parameterValue: .from_my_mument_detail)
                } else {
                    sendGAEvent(eventName: .mument_history_view, parameterValue: .from_other_mument_detail)
                }
            }
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mumentCardView.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        mumentCardView.menuIconButton.press { [weak self] in
            if UserDefaultsManager.userId == self?.dataSource?.user.id {
                self?.present(self?.myMumentActionSheetVC ?? BaseVC(), animated: true)
            } else {
                self?.present(self?.othersMumentActionSheetVC ?? BaseVC(), animated: true)
            }
        }
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
        songDetailVC.setDetailData(userId: self.userId,
                                   musicData: self.musicData)
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
    
    private func setMyMumentMenuActionSheet() {
        self.myMumentActionSheetVC.actionTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.myMumentActionSheetVC.actionTableView.deselectRow(at: indexPath, animated: true)
                self.myMumentActionSheetVC.dismiss(animated: true) {
                    switch indexPath.row {
                    case 0:
                        if self.isPenaltyUser() {
                            self.checkUserPenalty(self)
                        } else {
                            let editVC = WriteVC(
                                isEdit: true,
                                mumentId: self.mumentId,
                                detailData: self.dataSource ?? MumentDetailResponseModel(
                                    isFirst: false,
                                    content: "",
                                    impressionTag: [],
                                    isLiked: false,
                                    count: 0,
                                    likeCount: 0,
                                    createdAt: "",
                                    feelingTag: [],
                                    user: MUMENT.MumentDetailResponseModel.User(id: 0, image: Optional(""), name: ""),
                                    isPrivate: false
                                ),
                                detailSongData: self.musicData)
                            self.present(editVC, animated: true)
                        }
                    case 1:
                        let mumentAlert = MumentAlertWithButtons(titleType: .onlyTitleLabel, OKTitle: "삭제")
                        mumentAlert.setTitle(title: "삭제하시겠어요?")
                        self.present(mumentAlert, animated: true)
                        
                        mumentAlert.OKButton.press {
                            self.requestDeleteMument()
                            if self.dataSource?.count == 1 {
                                if let NC = self.navigationController as? BaseNC {
                                    NC.popToRootViewController(animated: false)
                                    let songDetailVC = SongDetailVC()
                                    songDetailVC.setDetailData(userId: self.userId, musicData: self.musicData)
                                    NC.pushViewController(songDetailVC, animated: false)
                                }
                            } else {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    default: break
                    }
                }
            })
            .disposed(by: self.myMumentActionSheetVC.disposeBag )
    }
    
    private func setOthersMumentActionSheet() {
        self.othersMumentActionSheetVC.actionTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.othersMumentActionSheetVC.actionTableView.deselectRow(at: indexPath, animated: true)
                self.othersMumentActionSheetVC.dismiss(animated: true) {
                    switch indexPath.row {
                    case 0:
                        let reportMumentVC = ReportMumentVC()
                        reportMumentVC.setMumentId(mumentId: self.mumentId)
                        self.hideTabbar()
                        self.navigationController?.pushViewController(reportMumentVC, animated: true)
                        debugPrint("신고")
                    case 1:
                        let mumentAlert = MumentAlertWithButtons(titleType: .containedSubTitleLabel, OKTitle: "차단하기")
                        mumentAlert.setTitleSubTitle(title: "이 유저를 차단하시겠어요?", subTitle: "이 유저의 뮤멘트가 목록에서\n더는 보이지 않아요.")
                        self.present(mumentAlert, animated: true)
                        mumentAlert.setButtonAction()
                        mumentAlert.OKButton.press { [weak self] in
                            self?.postUserBlock()
                        }
                        debugPrint("차단")
                    default: break
                    }
                }
            })
            .disposed(by: self.othersMumentActionSheetVC.disposeBag )
    }
    
    private func sendMumentDetailGAEvent() {
        let previousViewController = self.navigationController?.previousViewController
        if previousViewController is HomeVC {
            sendGAEvent(eventName: .mument_detail_page, parameterValue: .from_home)
        } else if previousViewController is SongDetailVC {
            sendGAEvent(eventName: .mument_detail_page, parameterValue: .from_song_detail_page)
        } else if previousViewController is MumentHistoryVC {
            sendGAEvent(eventName: .mument_detail_page, parameterValue: .from_history_list)
        }
    }
}

// MARK: - UI
extension MumentDetailVC {
    
    private func setLayout() {
        view.addSubviews([navigationBarView, detailScrollView, instagramShareView])
        detailScrollView.addSubviews([detailContentView])
        detailContentView.addSubviews([mumentCardView, historyButton])
        
        navigationBarView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        detailScrollView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(navigationBarView.snp.bottom)
        }
        detailContentView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
        mumentCardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        historyButton.snp.makeConstraints{
            $0.top.equalTo(mumentCardView.snp.bottom).offset(30)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(335)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        instagramShareView.snp.makeConstraints {
            $0.height.width.equalToSuperview()
            $0.trailing.equalToSuperview().inset(-1000)
        }
    }
}

// MARK: - DetailMumentCardViewDelegate
extension MumentDetailVC: DetailMumentCardViewDelegate {
    func pushToLikedUserListVC() {
        let likedUserListVC = LikedUserListVC()
        likedUserListVC.setMumentId(mumentId: self.mumentId)
        self.navigationController?.pushViewController(likedUserListVC, animated: true)
    }
    
    func shareButtonClicked() {
        guard let data = dataSource else {return }
        instagramShareView.setData(data, musicData)
        
        let renderer = UIGraphicsImageRenderer(size: instagramShareView.bounds.size)
        let image = renderer.image { ctx in
            instagramShareView.drawHierarchy(in: instagramShareView.bounds, afterScreenUpdates: true)
        }
        
        if let storiesUrl = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storiesUrl) {
                guard let imageData = image.pngData() else { return }
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": "#d8d8d8",
                    "com.instagram.sharedSticker.backgroundBottomColor": "#d8d8d8"
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            } else {
                print("User doesn't have instagram on their device.")
                if let openStore = URL(string: "itms-apps://itunes.apple.com/app/instagram/id389801252"), UIApplication.shared.canOpenURL(openStore) {
                    UIApplication.shared.open(openStore, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

// MARK: - Network
extension MumentDetailVC {
    private func requestGetMumentDetail() {
        self.startActivityIndicator()
        MumentDetailAPI.shared.getMumentDetail(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? MumentDetailResponseModel {
                    self.dataSource = result
                    self.setData()
                    self.mumentCardView.setData(result, self.musicData, self.mumentId)
                    self.userId = result.user.id
                }
                self.stopActivityIndicator()
            case .requestErr(let statusCode, _):
                if let status = statusCode as? Int {
                    let mumentAlert: MumentAlertWithButtons = MumentAlertWithButtons(titleType: .containedSubTitleLabel, buttonType: .onlyOK)
                    
                    mumentAlert.OKButton.press { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                    
                    if status == 400 {
                        mumentAlert.setTitleSubTitle(
                            title: MessageType.privateMumentTitle.message,
                            subTitle: MessageType.sorry.message
                        )
                        self.present(mumentAlert, animated: true)
                    } else if status == 404 {
                        mumentAlert.setTitleSubTitle(
                            title: MessageType.deletedMumentTitle.message,
                            subTitle: MessageType.sorry.message
                        )
                        self.present(mumentAlert, animated: true)
                    } else {
                        self.makeAlert(title: MessageType.networkError.message)
                    }
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestDeleteMument() {
        self.startActivityIndicator()
        DeleteAPI.shared.deleteMument(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success(_):
                self.stopActivityIndicator()
                return
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func postUserBlock() {
        self.startActivityIndicator()
        MumentDetailAPI.shared.postUserBlock(mumentId: mumentId) { networkResult in
            switch networkResult {
            case .success:
                if let navigationController = self.navigationController as? BaseNC, let previousVC = navigationController.previousViewController as? BaseVC {
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)) {
                        previousVC.showToastMessage(message: "차단이 완료되었습니다.", color: .black)
                        self.stopActivityIndicator()
                    }
                    navigationController.popViewController(animated: true)
                    previousVC.viewWillAppear(true)
                }
            case .requestErr(let statusCode, _):
                if let statusCode = statusCode as? Int {
                    if statusCode == 400 {
                        if let navigationController = self.navigationController as? BaseNC, let previousVC = navigationController.previousViewController as? BaseVC {
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)) {
                                previousVC.makeAlert(title: MessageType.blockAlreadyBlockedUser.message)
                                self.stopActivityIndicator()
                            }
                            navigationController.popViewController(animated: true)
                            previousVC.viewWillAppear(true)
                        }
                    }
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
