//
//  SetProfileVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/11/14.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

final class SetProfileVC: BaseVC {
    
    // MARK: Components
    private let naviView: DefaultNavigationBar = DefaultNavigationBar(naviType: .leftArrowRightDone).then {
        $0.setTitleLabel(title: "프로필 설정")
        $0.doneButton.isEnabled = false
    }
    
    private let loadImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "mumentDefaultProfile"))
        imageView.isUserInteractionEnabled = false
        imageView.layer.cornerRadius = 131.adjustedH / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loadImageButton: UIButton = UIButton(type: .custom).then {
        $0.setBackgroundImage(UIImage(named: "mumentDarkenCamera"), for: .normal)
        $0.layer.cornerRadius = 131.adjustedH / 2
        $0.clipsToBounds = true
    }
    
    private let nickNameTextField: MumentTextField = MumentTextField().then {
        $0.text = UserInfo.shared.nickname
        $0.placeholder = "닉네임을 입력해주세요. (필수)"
    }
    
    private let infoLabel: UILabel = UILabel().then {
        $0.text = "특수문자 제외 2-15자"
        $0.font = .mumentB8M12
        $0.textColor = .mGray2
        $0.sizeToFit()
    }
    
    private let nickNameCountLabel: UILabel = UILabel().then {
        $0.text = "0/15"
        $0.textColor = .mGray1
        $0.setColor(to: "0", with: .mPurple1)
        $0.font = .mumentB8M12
        $0.sizeToFit()
    }
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let imagePickerController: UIImagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
    }
    private let actionSheetVC = MumentActionSheetVC(actionName: ["라이브러리에서 선택", "프로필 사진 삭제"])
    private let defaultProfileImage = UIImage(named: "mumentDefaultProfile")
    private let defaultProfileImageName: [String] = ["mumentProfileLove60", "mumentProfileSleep60", "mumentProfileSmile60"].shuffled()
    var isFirst: Bool = false
    var isProfileImageChanged = false {
        didSet {
            if self.isFirst {
                self.naviView.doneButton.isEnabled = self.isNicknameChanged
            } else {
                self.naviView.doneButton.isEnabled = self.isProfileImageChanged || self.isNicknameChanged
            }
        }
    }
    var isNicknameChanged = false {
        didSet {
            if self.isFirst {
                self.naviView.doneButton.isEnabled = self.isNicknameChanged
            } else {
                self.naviView.doneButton.isEnabled = self.isProfileImageChanged || self.isNicknameChanged
            }
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController.delegate = self
        self.setLayout()
        self.setClearButtonTapAction()
        self.checkNickNameIsValid()
        self.setNickNameCountLabel()
        self.checkEnterNickNameLimit()
        self.setLoadImageButtonAction()
        self.setDefaultImageView()
        self.setDoneButtonAction()
        self.setBackButtonAction()
    }
    
    // MARK: Methods
    /// 클리어 버튼 탭할 경우, 완료 버튼 비활성화하는 메서드
    private func setClearButtonTapAction() {
        nickNameTextField.clearButton.press { [weak self] in
            self?.naviView.doneButton.isEnabled = false
            self?.infoLabel.textColor = .mGray2
            self?.setNickNameCountLabel()
        }
    }
    
    /// 닉네임 유효성 검사 메서드
    private func checkNickNameIsValid() {
        nickNameTextField.rx.text
            .orEmpty
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                if changedText.count > 0 {
                    if self.isFirst {
                        let regex = "[가-힣ㄱ-ㅎㅏ-ㅣA-Za-z0-9\\s]{0,}"
                        if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: changedText) && changedText.trimmingCharacters(in: .whitespaces).count >= 2 {
                            self.isNicknameChanged = true
                            self.infoLabel.textColor = .mGray2
                        } else {
                            self.naviView.doneButton.isEnabled = false
                            self.infoLabel.textColor = .mRed
                        }
                    } else {
                        if changedText == UserInfo.shared.nickname {
                            self.isNicknameChanged = false
                        } else {
                            let regex = "[가-힣ㄱ-ㅎㅏ-ㅣA-Za-z0-9\\s]{0,}"
                            if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: changedText) && changedText.trimmingCharacters(in: .whitespaces).count >= 2 {
                                self.isNicknameChanged = true
                                self.infoLabel.textColor = .mGray2
                            } else {
                                self.naviView.doneButton.isEnabled = false
                                self.infoLabel.textColor = .mRed
                            }
                        }
                    }

                } else {
                    self.naviView.doneButton.isEnabled = false
                    self.infoLabel.textColor = .mGray2
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 닉네임 글자 수를 Label에 띄우는 메서드
    private func setNickNameCountLabel() {
        nickNameTextField.rx.text
            .orEmpty
            .subscribe(onNext: { changedText in
                DispatchQueue.main.async {
                    let countString = "\(changedText.count)"
                    self.nickNameCountLabel.text = countString + "/15"
                    self.nickNameCountLabel.setColor(to: countString, with: .mPurple1)
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 닉네임 글자 수가 초과될 경우 입력을 제한하는 메서드
    private func checkEnterNickNameLimit() {
        nickNameTextField.rx.text
            .orEmpty
            .skip(1)
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { changedText in
                if changedText.count > 15 {
                    let index = changedText.index(changedText.startIndex, offsetBy: 15)
                    self.nickNameTextField.text = String(changedText[..<index])
                    self.nickNameTextField.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 프로필 사진 설정 버튼 액션 메서드
    private func setLoadImageButtonAction() {
        self.loadImageButton.press { [weak self] in
            self?.actionSheetVC.actionTableView.rx.itemSelected
                .subscribe(onNext: { indexPath in
                    self?.actionSheetVC.actionTableView.deselectRow(at: indexPath, animated: true)
                    self?.actionSheetVC.dismiss(animated: true) {
                        switch indexPath.row {
                        case 0:
                            self?.openLibrary(presentingVC: self ?? BaseVC())
                        case 1:
                            if self?.loadImageView.image != self?.defaultProfileImage {
                                self?.loadImageView.image = self?.defaultProfileImage
                                self?.isProfileImageChanged = true
                            }
                        default: break
                        }
                    }
                }).disposed(by: self?.actionSheetVC.disposeBag ?? DisposeBag())
            self?.present(self?.actionSheetVC ?? BaseVC(), animated: true)
        }
    }
    
    private func setDefaultImageView() {
        UserInfo.shared.profileImageURL.getImage { image in
            DispatchQueue.main.async {
                self.loadImageView.image = self.isFirst ? self.defaultProfileImage : image
            }
        }
    }
    
    /// 완료 버튼 액션 메서드
    private func setDoneButtonAction() {
        self.naviView.doneButton.press { [weak self] in
            self?.view.endEditing(true)
            
            if self?.nickNameTextField.text == UserInfo.shared.nickname {
                self?.requestSetProfile(nickname: UserInfo.shared.nickname)
            } else {
                self?.checkDuplicatedNickname(nickname: self?.nickNameTextField.clearSideEmptyText() ?? "")
            }
        }
    }
    
    private func setBackButtonAction() {
        self.naviView.backButton.press {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func makeProfileImageData() -> Data {
        if let image = self.loadImageView.image {
            if image == self.defaultProfileImage {
                let imageView = UIImageView(image: UIImage(named: self.defaultProfileImageName[0]))
                return imageView.resizeWithWidth(width: 500)?.pngData() ?? Data()
            } else {
                return self.loadImageView.resizeWithWidth(width: 500)?.pngData() ?? Data()
            }
        } else {
            return Data()
        }
    }
}

// MARK: - Network
extension SetProfileVC {
    private func checkDuplicatedNickname(nickname: String) {
        self.startActivityIndicator()
        MyPageAPI.shared.checkDuplicatedNickname(nickname: nickname) { networkResult in
            switch networkResult {
            case .success(let status):
                if let result = status as? Int {
                    switch result {
                    case 200:
                        self.stopActivityIndicator()
                        self.showToastMessage(message: "중복된 닉네임이 존재합니다.", color: .red)
                    case 204:
                        self.requestSetProfile(nickname: nickname)
                    default:
                        self.stopActivityIndicator()
                        self.makeAlert(title: MessageType.networkError.message)
                    }
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func requestSetProfile(nickname: String) {
        let profileData = SetProfileRequestModel(
            image: self.makeProfileImageData(),
            nickname: nickname
        )
        
        MyPageAPI.shared.setProfile(data: profileData) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? SetProfileResponseModel {
                    self.setUserInfo(
                        accessToken: result.accessToken,
                        refreshToken: result.refreshToken,
                        userId: result.id
                    )
                    self.setUserProfile(nickname: result.userName, profileImageURL: result.image)
                    self.stopActivityIndicator()
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    } else {
                        let tabBarController = MumentTabBarController()
                        tabBarController.modalPresentationStyle = .fullScreen
                        tabBarController.modalTransitionStyle = .crossDissolve
                        self.present(tabBarController, animated: true)
                    }
                }
            default:
                self.stopActivityIndicator()
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UI
extension SetProfileVC {
    private func setLayout() {
        self.view.addSubviews([naviView, loadImageView, loadImageButton, nickNameTextField, infoLabel, nickNameCountLabel])
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        loadImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(131.adjustedH)
            $0.top.equalTo(naviView.snp.bottom).offset(79.adjustedH)
        }
        
        loadImageButton.snp.makeConstraints {
            $0.edges.equalTo(self.loadImageView)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(loadImageButton.snp.bottom).offset(64.adjustedH)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            $0.left.equalTo(nickNameTextField)
        }
        
        nickNameCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel)
            $0.right.equalTo(nickNameTextField)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SetProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.isProfileImageChanged = true
                self.loadImageView.image = image
            }
        }
        self.imagePickerController.dismiss(animated: true)
    }
    
    func openLibrary(presentingVC: UIViewController) {
        presentingVC.present(imagePickerController, animated: true)
    }
}
