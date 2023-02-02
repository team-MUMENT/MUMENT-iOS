//
//  MumentDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

final class MumentDetailVC: BaseVC, UIActionSheetDelegate {
    
    // MARK: - Components
    private let navigationBarView = DefaultNavigationBar()
    private let detailScrollView = UIScrollView()
    private let detailContentView = UIView().then {
        $0.backgroundColor = .mBgwhite
    }
    private let mumentCardView = DetailMumentCardView()
    private let historyButton = UIButton().then{
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
    var mumentId: Int?
    private var userId = 0
    private var musicData: MusicDTO = MusicDTO(id: "", title: "", artist: "", albumUrl: "")
    private var dataSource: MumentDetailResponseModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setClickEventHandlers()
        mumentCardView.setDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetMumentDetail()
    }
    
    // MARK: - Functions
    func setData(){
        DispatchQueue.main.async {
            self.navigationBarView.setTitle("뮤멘트")
            self.mumentCardView.setData(self.dataSource ?? MumentDetailResponseModel(isFirst: false, content: "", impressionTag: [], isLiked: false, count: 0, likeCount: 0, createdAt: "", feelingTag: [], user: MUMENT.MumentDetailResponseModel.User(id: 0, image: Optional(""), name: "")), self.musicData, self.mumentId ?? 0)
            self.historyButtonText = "     \(self.dataSource?.count ?? 0)개의 뮤멘트가 있는 히스토리 보러가기"
        }
    }
    
    func setData(mumentId: Int, musicData: MusicDTO) {
        self.mumentId = mumentId
        self.musicData = musicData
    }
    
    private func setClickEventHandlers(){
        
        navigationBarView.backButton.press{
            self.navigationController?.popViewController(animated: true)
        }
        
        historyButton.press{
            let mumentHistoryVC = MumentHistoryVC()
            mumentHistoryVC.setHistoryData(userId: self.userId, musicData: self.musicData)
            self.navigationController?.pushViewController(mumentHistoryVC, animated: true)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mumentCardView.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        mumentCardView.menuIconButton.press{
            
            if UserDefaultsManager.userId == self.dataSource?.user.id {
                let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let updatingAction: UIAlertAction = UIAlertAction(title: "수정하기", style: .default) { action -> Void in
                    let editVC = WriteVC(
                        isEdit: true,
                        mumentId: self.mumentId ?? 0,
                        detailData: self.dataSource ?? MumentDetailResponseModel(
                            isFirst: false,
                            content: "",
                            impressionTag: [],
                            isLiked: false,
                            count: 0,
                            likeCount: 0,
                            createdAt: "",
                            feelingTag: [],
                            user: MUMENT.MumentDetailResponseModel.User(id: 0, image: Optional(""), name: "")
                        ),
                        detailSongData: self.musicData)
                    self.present(editVC, animated: true)
                }
                
                let deletingAction: UIAlertAction = UIAlertAction(title: "삭제하기", style: .default) { action -> Void in
                    let mumentAlert = MumentAlertWithButtons(titleType: .onlyTitleLabel, OKTitle: "삭제")
                    mumentAlert.setTitle(title: "삭제하시겠어요?")
                    self.present(mumentAlert, animated: true)
                    
                    mumentAlert.OKButton.press {
                        self.requestDeleteMument()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel) { action -> Void in }
                
                actionSheetController.addAction(updatingAction)
                actionSheetController.addAction(deletingAction)
                actionSheetController.addAction(cancelAction)
                
                self.present(actionSheetController, animated: true)
            } else {
                // 차단하기, 신고하기
                print("Others")
            }
        }
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
        songDetailVC.setDetailData(userId: self.userId, musicId: self.musicData.id)
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

// MARK: - UI
extension MumentDetailVC {
    
    private func setLayout() {
        view.addSubviews([navigationBarView,detailScrollView, instagramShareView])
        detailScrollView.addSubviews([detailContentView])
        detailContentView.addSubviews([mumentCardView,historyButton])
        
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
        MumentDetailAPI.shared.getMumentDetail(mumentId: mumentId ?? 0) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? MumentDetailResponseModel {
                    self.dataSource = result
                    self.setData()
                    self.mumentCardView.setData(result, self.musicData, self.mumentId ?? 0)
                    self.userId = result.user.id
                }
                
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestDeleteMument() {
        DeleteAPI.shared.deleteMument(mumentId: mumentId ?? 0) { networkResult in
            switch networkResult {
            case .success(_):
                return
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
