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
    private let dummyData = MumentDetailVCModel(profileImageName: "image5", writerName: "이수지", albumImageName: "image4", isFirst: true, impressionTags: [100,101,102], feelingTags:[], songtitle:"하늘나라", artist:"혁오", contents:
//                                                    ""
//                                                    "추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다."
                                                "추억과 쓸쓸함과 하나에 다하지 새겨지는 버리었습니다. 아스라히 별 이국 잔디가 있습니다. 애기 아직 이네들은 있습니다. 파란 다 그리워 강아지, 아직 헤일 말 나의 있습니다. 쓸쓸함과 가득 아침이 된 이웃 딴은 있습니다. 이름을 별 보고, 쓸쓸함과 벌써 버리었습니다. 언덕 나는 아무 하나에 말 위에 둘 별 듯합니다. 별 위에도 이름을 까닭이요, 거외다. 사랑과 파란 너무나 말 잔디가 릴케 봅니다. 없이 내일 이제 까닭입니다. 별 추억과 헤는 다 까닭이요, 가을로 듯합니다. 그러나 마디씩 속의 시인의 애기 것은 나는 있습니다. 가을로 어머니 시와 우는 이름과 강아지, 시인의 봅니다. 패, 시인의 가을로 별 어머니 봅니다. 책상을 시인의 당신은 가을로 내일 가득 있습니다. 하나에 별 사람들의 까닭입니다. 한 우는 어머님, 별 언덕 봅니다. 추억과 차 이름과, 나는 남은 마리아 당신은 봅니다."
                                                , createdAt:"1 Sep, 2020", isLiked:true, heartCount:15, mumentCount:5)
    private var historyButtonText: String = "" {
        didSet{
            historyButton.setAttributedTitle(NSAttributedString(string: historyButtonText,attributes: attributes), for: .normal)
        }
    }
    var mumentId: String?
    private var dataSource: MumentDetailResponseModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setClickEventHandlers()
        //        requestGetMumentDetail()
        setDummyData()
        mumentCardView.setDelegate(delegate: self)
    }
    
    // MARK: - Functions
    func setData(){
        DispatchQueue.main.async {
            self.navigationBarView.setTitle("뮤멘트")
            self.mumentCardView.setData(self.dataSource ?? MumentDetailResponseModel(isFirst: false, content: "", impressionTag: [], isLiked: false, count: 0, music: MUMENT.MumentDetailResponseModel.Music(id: "", name: "", image: Optional(""), artist: " "), likeCount: 0, createdAt: "", feelingTag: [], user: MUMENT.MumentDetailResponseModel.User(id: "", image: Optional(""), name: "")), mumentId: self.mumentId ?? "")
            self.historyButtonText = "     \(self.dataSource?.count ?? 0)개의 뮤멘트가 있는 히스토리 보러가기"
        }
    }
    
    private func setDummyData() {
        self.navigationBarView.setTitle("뮤멘트")
        self.mumentCardView.setData(dummyData)
        
        self.historyButtonText = "     \(self.dataSource?.count ?? 0)개의 뮤멘트가 있는 히스토리 보러가기"
    }
    
    private func setClickEventHandlers(){
        
        navigationBarView.backButton.press{
            self.navigationController?.popViewController(animated: true)
        }
        
        historyButton.press{
            let mumentHistoryVC = MumentHistoryVC()
            mumentHistoryVC.musicId = self.dataSource?.music.id
            mumentHistoryVC.userId = self.dataSource?.user.id
            self.navigationController?.pushViewController(mumentHistoryVC, animated: true)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mumentCardView.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        mumentCardView.menuIconButton.press{
            
            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let updatingAction: UIAlertAction = UIAlertAction(title: "수정하기", style: .default) { action -> Void in
                let editVC = WriteVC(isEdit: true, detailData: self.dataSource ?? MumentDetailResponseModel(isFirst: false, content: "", impressionTag: [], isLiked: false, count: 0, music: MUMENT.MumentDetailResponseModel.Music(id: "", name: "", image: Optional(""), artist: " "), likeCount: 0, createdAt: "", feelingTag: [], user: MUMENT.MumentDetailResponseModel.User(id: "", image: Optional(""), name: "")))
                self.present(editVC, animated: true)
            }
            
            let deletingAction: UIAlertAction = UIAlertAction(title: "삭제하기", style: .default) { action -> Void in
                let mumentAlert = MumentAlertWithButtons(titleType: .onlyTitleLabel)
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
            
            self.present(actionSheetController, animated: true) {
                print("option menu presented")
            }
        }
        
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
        songDetailVC.musicId = dataSource?.music.id
        songDetailVC.songInfoData = SongInfoResponseModel.Music(id: dataSource?.music.id ?? "", name: dataSource?.music.name ?? "", image: dataSource?.music.image ?? "", artist: dataSource?.music.artist ?? "")
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
        instagramShareView.setDummyData(dummyData)
        
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
        MumentDetailAPI.shared.getMumentDetail(mumentId: mumentId ?? "", userId: UserInfo.shared.userId ?? "") { networkResult in
            
            switch networkResult {
            case .success(let response):
                if let result = response as? MumentDetailResponseModel {
                    self.dataSource = result
                    self.setData()
                    self.mumentCardView.setData(result,mumentId: self.mumentId ?? "")
                }
                
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestDeleteMument() {
        DeleteAPI.shared.deleteMument(mumentId: mumentId ?? "") { networkResult in
            
            switch networkResult {
            case .success(_):
                return
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
