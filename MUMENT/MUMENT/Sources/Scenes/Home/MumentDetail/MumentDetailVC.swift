//
//  MumentDetailVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class MumentDetailVC: BaseVC, UIActionSheetDelegate {
    
    // MARK: - Properties
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
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.mumentC1R12,
        .foregroundColor: UIColor.mGray1
    ]
    
    var historyButtonText: String = "" {
        didSet{
            historyButton.setAttributedTitle(NSAttributedString(string: historyButtonText,attributes: attributes), for: .normal)
        }
    }
    
    var dataSource: [MumentDetailVCModel] = MumentDetailVCModel.sampleData
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setData()
        setClickEventHandlers()
    }
    
    // MARK: - Functions
    func setData(){
        navigationBarView.setTitle("뮤멘트")
        mumentCardView.setData(dataSource[0])
        historyButtonText = "     \(dataSource[0].mumentCount)개의 뮤멘트가 있는 히스토리 보러가기"
    }
    
    func setClickEventHandlers(){
        
        navigationBarView.backbutton.press{
            self.navigationController?.popViewController(animated: true)
        }
        
        historyButton.press{
            let mumentHistoryVC = MumentHistoryVC()
            self.navigationController?.pushViewController(mumentHistoryVC, animated: true)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mumentCardView.songInfoView.addGestureRecognizer(tapGestureRecognizer)
        mumentCardView.menuIconButton.press{

            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let updatingAction: UIAlertAction = UIAlertAction(title: "수정하기", style: .default) { action -> Void in
                self.tabBarController?.selectedIndex = 1
            }

            let deletingAction: UIAlertAction = UIAlertAction(title: "삭제하기", style: .default) { action -> Void in
                let mumentAlert = MumentAlertWithButtons(titleType: .onlyTitleLabel)
                    mumentAlert.setTitle(title: "삭제하시겠어요?")
                self.present(mumentAlert, animated: true)
                
                mumentAlert.OKButton.press {
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
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let songDetailVC = SongDetailVC()
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }
}

// MARK: - UI
extension MumentDetailVC {
    
    private func setLayout() {
        view.addSubviews([navigationBarView,detailScrollView])
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
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
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
    }
}

// MARK: - Network
extension MumentDetailVC {
  private func requestGetAllMument(musicId: String, userId: String, isOrderLiked: Bool) {
      SongDetailAPI.shared.getAllMuments(musicId: musicId, userId: userId, isOrderLiked: isOrderLiked) { networkResult in
      switch networkResult {
         
      case .success(let response):
        if let res = response as? AllMumentsResponseModel {
          print(res.mumentList)
        }
      default:
        self.makeAlert(title: "네트워킁 오류로 어쩌구..죄송")
      }
    }
  }
}
