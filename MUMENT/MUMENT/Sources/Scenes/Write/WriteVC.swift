//
//  WriteVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class WriteVC: BaseVC {
    
    // MARK: - Properties
    private let writeScrollView = UIScrollView()
    private let writeContentView = UIView().then {
        $0.backgroundColor = .mBgwhite
    }
    private lazy var naviView = DefaultNavigationBar(naviType: .leftCloseRightDone).then {
        $0.setTitleLabel(title: isEdit ? "수정하기" : "기록하기")
        $0.doneButton.isEnabled = false
    }
    private let selectMusicLabel = UILabel().then {
        $0.text = "곡을 선택해주세요."
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let searchButton = UIButton(type: .system).then {
        $0.backgroundColor = .mGray5
        $0.layer.cornerRadius = 10
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "mumentSearch")
        $0.configuration?.imagePadding = 10
        $0.setAttributedTitle(NSAttributedString(string: "곡, 아티스트",attributes: [
            .font: UIFont.mumentB4M14,
            .foregroundColor: UIColor.mGray1
        ]), for: .normal)
        $0.contentHorizontalAlignment = .left
    }
    private let firstTimeMusicLabel = UILabel().then {
        $0.text = "처음 들은 곡인가요?"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let firstListenButton = UIButton(type: .custom).then {
        $0.setTitle("처음 들어요", for: .normal)
        $0.setBackgroundColor(.mPurple2, for: .selected)
        $0.setBackgroundColor(.mGray5, for: .normal)
        $0.setBackgroundColor(.mGray5, for: .disabled)
        $0.setTitleColor(.mPurple1, for: .selected)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.makeRounded(cornerRadius: 11.adjustedH)
    }
    private let againListenButton = UIButton(type: .custom).then {
        $0.setTitle("다시 들었어요", for: .normal)
        $0.setBackgroundColor(.mPurple2, for: .selected)
        $0.setBackgroundColor(.mGray5, for: .normal)
        $0.setBackgroundColor(.mGray5, for: .disabled)
        $0.setTitleColor(.mPurple1, for: .selected)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.makeRounded(cornerRadius: 11.adjustedH)
    }
    private let impressionLabel = UILabel().then {
        $0.text = "무엇이 인상적이었나요?"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let impressionTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let feelLabel = UILabel().then {
        $0.text = "감정을 선택해보세요."
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let feelTagScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    private let feelTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.contentInset = .zero
        $0.isScrollEnabled = false
    }
    private let contentLabel = UILabel().then {
        $0.text = "이 순간의 여운을 글로 남겨보세요."
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let contentTextView = UITextView().then {
        $0.clipsToBounds = true
        $0.makeRounded(cornerRadius: 11.adjustedH)
        $0.backgroundColor = .mGray5
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 13, bottom: 15, right: 13)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        $0.font = .mumentB6M13
        $0.autocapitalizationType = .none
        $0.textColor = .mBlack2
    }
    private let countTextViewLabel = UILabel().then {
        $0.font = .mumentB6M13
        $0.textColor = .mGray2
        $0.text = "0/1000"
    }
    private let isPrivateToggleButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "mumentToggleOff"), for: .normal)
        $0.setImage(UIImage(named: "mumentToggleOn"), for: .selected)
    }
    private let privateLabel = UILabel().then {
        $0.text = "공개글"
        $0.font = .mumentB4M14
        $0.textColor = .mGray1
        $0.sizeToFit()
    }
    private var selectedMusicView = WriteMusicView()
    
    var clickedImpressionTag: [Int] = [] {
        didSet {
            postMumentData.impressionTag = clickedImpressionTag
        }
    }
    var clickedFeelTag: [Int] = [] {
        didSet {
            postMumentData.feelingTag = clickedFeelTag
        }
    }
    let impressionTagData = ["🎙 음색", "🎶 멜로디", "🥁 비트", "🎸 베이스", "🖋 가사", "🛫 도입부"]
    let feelTagData = ["🎡 벅참", "😄 신남", "💐 설렘", "😚 행복", "🙌 자신감", "🍀 여유로움", "🍁 센치함", "😔 우울", "🕰 그리움", "🛌 외로움", "🌋 스트레스", "⌛️ 아련함", "💭 회상", " 👥 위로", "🌅 낭만", "☕️ 차분"]
    
    private let tagCellHeight = 35
    private let cellVerticalSpacing = 10
    let disposeBag = DisposeBag()
    var isFirstListen = false
    var isFirstListenActivated = true
    var musicId = ""
    var postMumentData: PostMumentBodyModel = PostMumentBodyModel()
    var isEdit = false
    private var detailData: MumentDetailResponseModel?
    private var detailSongData: MusicDto?
    
    // MARK: Initialization
    init(isEdit: Bool = false, detailData: MumentDetailResponseModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.isEdit = isEdit
        self.modalPresentationStyle = .overFullScreen
        self.detailData = detailData
    }
    
    init(isEdit: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        self.isEdit = isEdit
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        setTagCV()
        setLayout()
        setNaviView()
        setRadioButtonSelectStatus(button: firstListenButton, isSelected: isFirstListen)
        setRadioButtonSelectStatus(button: againListenButton, isSelected: isFirstListen)
        setRadioButton()
        setIsPrivateToggleButton()
        setContentTextView()
        registerCell()
        hideKeyboardWhenTappedAround()
        setContentTextCounting()
        setSearchButton()
        setRemoveSelectedMusicButton()
        setSelectedMusicViewPressed()
        setCompleteButton()
        setIsEnableCompleteButton(isEnabled: false)
        if isEdit {
            if let data = self.detailData, let songData = self.detailSongData{
                self.setEditView(data, songData)
            }
        }
    }
    
    // MARK: - Functions
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedMusicViewForReceived(_:)), name: .sendSearchResult, object: nil)
    }
    
    @objc func setSelectedMusicViewForReceived(_ notification: Notification){
        self.setSelectedMusicView()
        if let receivedData = notification.object as? SearchResultResponseModelElement {
            self.selectedMusicView.setData(data: receivedData)
//            getIsFirst(userId: UserInfo.shared.userId ?? "", musicId: receivedData.id)
            musicId = receivedData.id
            setIsEnableCompleteButton(isEnabled: true)
        }
    }
    
    private func setEditView(_ data: MumentDetailResponseModel,_ songData: MusicDto) {
        self.setSelectedMusicView()
        
        let musicData = SearchResultResponseModelElement(id: songData.musicId, name: songData.musicTitle, artist: songData.artist, image: songData.albumUrl)
        self.selectedMusicView.setData(data: musicData)
//        self.getIsFirst(userId: UserInfo.shared.userId ?? "", musicId: songData.musicId)
        self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: data.isFirst)
        self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: !(data.isFirst))
        self.musicId = songData.musicId
        
        // 기존의 태그를 선택하도록 설정
        let feelingTags: [Int] = data.feelingTag
        let impressionTags: [Int] = data.impressionTag
        feelingTags.forEach { tag in
            self.feelTagCV.selectItem(at: IndexPath(row: tag - 200, section: 0), animated: false, scrollPosition: .init())
            self.collectionView(self.feelTagCV, didSelectItemAt: IndexPath(row: tag - 200, section: 0))
        }
        impressionTags.forEach { tag in
            self.impressionTagCV.selectItem(at: IndexPath(row: tag - 100, section: 0), animated: false, scrollPosition: .init())
            self.collectionView(self.impressionTagCV, didSelectItemAt: IndexPath(row: tag - 100, section: 0))
        }
        
        self.contentTextView.text = data.content
        self.contentTextView.textColor = .mBlack2
        
        self.isPrivateToggleButton.isSelected = false
        
        self.setIsEnableCompleteButton(isEnabled: true)
    }
    
    private func setCompleteButton() {
        self.naviView.doneButton.press { [weak self] in
            self?.feelTagCV.indexPathsForSelectedItems?.forEach {
                let cell =  self?.feelTagCV.cellForItem(at: $0) as! WriteTagCVC
                self?.clickedFeelTag.append(cell.contentLabel.text?.tagInt() ?? 0)
            }
            
            self?.impressionTagCV.indexPathsForSelectedItems?.forEach {
                let cell =  self?.feelTagCV.cellForItem(at: $0) as! WriteTagCVC
                self?.clickedImpressionTag.append(cell.contentLabel.text?.tagInt() ?? 0)
            }
            
            let contentText = self?.contentTextView.textColor == .mBlack2 ? self?.contentTextView.text : ""
            
            let selectedMusicData = self?.selectedMusicView.selectedMusicData()
            
            self?.postMumentData = PostMumentBodyModel(
                isFirst: self?.firstListenButton.isSelected ?? false,
                impressionTag: self?.clickedImpressionTag ?? [],
                feelingTag: self?.clickedFeelTag ?? [],
                content: contentText ?? "",
                isPrivate: self?.isPrivateToggleButton.isSelected ?? false,
                musicId: selectedMusicData?.id ?? "",
                musicArtist: selectedMusicData?.artist ?? "",
                musicImage: selectedMusicData?.image ?? "",
                musicName: selectedMusicData?.name ?? ""
            )
            
            self?.postMument(
                musicId: self?.musicId ?? "",
                data: self?.postMumentData ?? PostMumentBodyModel()
            )
        }
    }
    
    private func setIsEnableCompleteButton(isEnabled: Bool) {
        self.naviView.doneButton.isEnabled = isEnabled
        self.firstListenButton.isEnabled = isEnabled
        self.againListenButton.isEnabled = isEnabled
    }
    
    private func setSearchButton() {
        searchButton.press { [weak self] in
            let searchBottomSheet = SearchBottomSheetVC()
            self?.present(searchBottomSheet, animated: false) {
                searchBottomSheet.showBottomSheetWithAnimation()
            }
        }
    }
    
    private func setRadioButton() {
        firstListenButton.press {
            self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: true)
            self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: false)
            if self.isFirstListenActivated == false {
                self.showToastMessage(message: "‘처음 들어요'는 한 곡당 한 번만 선택할 수 있어요.", color: .black)
                self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: false)
                self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: true)
            }
            
        }
        againListenButton.press {
            self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: false)
            self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: true)
        }
    }
    
    private func setTagCV() {
        [impressionTagCV, feelTagCV].forEach {
            $0.dataSource = self
            $0.delegate = self
            $0.allowsMultipleSelection = true
            $0.layoutMargins = .zero
            $0.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
        }
    }
    
    private func setIsPrivateToggleButton() {
        isPrivateToggleButton.press {
            self.isPrivateToggleButton.isSelected.toggle()
            self.privateLabel.text = self.isPrivateToggleButton.isSelected ? "비밀글" : "공개글"
        }
    }
    
    private func setContentTextView() {
        contentTextView.delegate = self
        contentTextView.text = "글로 쓰지 않아도 뮤멘트를 저장할 수 있어요."
        contentTextView.textColor = .mGray1
    }
    
    private func setContentTextCounting() {
        contentTextView.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { changedText in
                if self.contentTextView.textColor == .mBlack2 {
                    DispatchQueue.main.async {
                        self.countTextViewLabel.text = "\(changedText.count)/1000"
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setRemoveSelectedMusicButton() {
        if isEdit {
            selectedMusicView.removeButton.removeFromSuperview()
        } else {
            selectedMusicView.removeButton.press { [weak self] in
                self?.removeSelectedMusicView()
                self?.setIsEnableCompleteButton(isEnabled: false)
            }
        }
    }
    
    private func setDefaultView() {
        // TODO: 함수화..
        
        /// 선택된 음악 초기화
        self.removeSelectedMusicView()
        
        /// 처음/다시 response값으로 초기화
        self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: self.isFirstListen )
        self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: self.isFirstListen)
        
        /// 인상/감정 태그 배열 초기화
        self.feelTagCV.reloadData()
        self.impressionTagCV.reloadData()
        self.clickedFeelTag = []
        self.clickedImpressionTag = []
        
        /// 글 초기화
        self.contentTextView.text =  "글을 쓰지 않아도 뮤멘트를 저장할 수 있어요."
        self.contentTextView.textColor = .mGray1
        
        /// 공개/비공개 토글 초기화(default: toggle off)
        self.isPrivateToggleButton.isSelected = false
        
        /// 완료 버튼 비활성화
        self.setIsEnableCompleteButton(isEnabled: false)
    }
    
    private func setSelectedMusicViewPressed() {
        if !isEdit {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSelectedMusicView(_:)))
            selectedMusicView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func didTapSelectedMusicView(_ sender: UITapGestureRecognizer) {
        let searchBottomSheet = SearchBottomSheetVC()
        self.present(searchBottomSheet, animated: false) {
            searchBottomSheet.showBottomSheetWithAnimation()
        }
    }
    
    private func setNaviView() {
        self.naviView.closeButton.press { [weak self] in
            let mumentAlert = MumentAlertWithButtons(titleType: .containedSubTitleLabel)
            
            if self?.isEdit == true {
                mumentAlert.setTitleSubTitle(title: "수정을 취소하시겠어요?", subTitle: "확인 선택 시 변경사항이 저장되지 않습니다.")
            } else {
                mumentAlert.setTitleSubTitle(title: "뮤멘트 기록을 취소하시겠어요?", subTitle: "확인 선택 시, 작성 중인 내용이 삭제됩니다.")
            }
            
            self?.present(mumentAlert, animated: true)
            
            mumentAlert.OKButton.press { [weak self] in
                self?.dismiss(animated: true)
            }
        }
        self.naviView.doneButton.press {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case impressionTagCV:
            return impressionTagData.count
        case feelTagCV:
            return feelTagData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteTagCVC.className, for: indexPath) as! WriteTagCVC
        switch collectionView {
        case impressionTagCV:
            cell.setData(data: impressionTagData[indexPath.row])
            return cell
        case feelTagCV:
            cell.setData(data: feelTagData[indexPath.row])
            return cell
        default: return cell
        }
    }
}

// MARK: - Network
extension WriteVC {
    private func getIsFirst(musicId: String) {
        WriteAPI.shared.getIsFirst(musicId: musicId) { networkResult in
            switch networkResult {
            case .success(let response):
                if let result = response as? GetIsFirstResponseModel {
                    self.setRadioButtonSelectStatus(button: self.firstListenButton, isSelected: result.isFirst)
                    self.setRadioButtonSelectStatus(button: self.againListenButton, isSelected: !(result.isFirst))
                    self.isFirstListenActivated = result.firstavailable
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
    
    private func postMument(musicId: String, data: PostMumentBodyModel) {
        WriteAPI.shared.postMument(musicId: musicId, data: data) { networkResult in
            switch networkResult {
            case .success(let response):
                if response is PostMumentResponseModel {
                    self.setDefaultView()
                    self.showToastMessage(message: "🎉 뮤멘트가 작성되었어요!", color: .black)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WriteVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizingCell = WriteTagCVC()
        switch collectionView {
        case impressionTagCV:
            sizingCell.setData(data: impressionTagData[indexPath.row])
        case feelTagCV:
            sizingCell.setData(data: feelTagData[indexPath.row])
        default: break
        }
        
        sizingCell.contentLabel.sizeToFit()
        
        let cellWidth = sizingCell.contentLabel.frame.width + 26
        let cellHeight = tagCellHeight
        return CGSize(width: cellWidth, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Int(feelTagCV.indexPathsForSelectedItems?.count ?? 0) + Int(impressionTagCV.indexPathsForSelectedItems?.count ?? 0) > 5 {
            self.showToastMessage(message: "감상 태그는 최대 5개까지 선택할 수 있어요.", color: .black)
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
                cell.isSelected = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
            cell.isSelected = false
        }
    }
}

// MARK: - UITextViewDelegate
extension WriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.mGray1 {
            contentTextView.text = nil
            contentTextView.textColor = .mBlack2
        }
        
        writeScrollView.setContentOffset(CGPoint(x: 0, y: contentLabel.frame.midY - 20.adjustedH), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.isEmpty {
            contentTextView.text =  "글을 쓰지 않아도 뮤멘트를 저장할 수 있어요."
            contentTextView.textColor = .mGray1
        }
        
        writeScrollView.setContentOffset(CGPoint(x: 0, y: writeScrollView.contentSize.height - writeScrollView.bounds.height), animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = contentTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 1000
    }
}

// MARK: - UI
extension WriteVC {
    
    private func setRadioButtonSelectStatus(button: UIButton, isSelected: Bool) {
        button.isSelected = isSelected
        button.titleLabel?.font = isSelected ? .mumentB2B14 : .mumentB4M14
    }
    
    private func registerCell() {
        impressionTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
        feelTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
    }
    
    private func setSelectedMusicView() {
        self.writeContentView.addSubview(selectedMusicView)
        
        selectedMusicView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(selectMusicLabel.snp.top)
            $0.bottom.equalTo(searchButton.snp.bottom)
        }
    }
    
    private func removeSelectedMusicView() {
        self.selectedMusicView.removeFromSuperview()
    }
    
    private func setLayout() {
        view.addSubviews([naviView, writeScrollView])
        writeScrollView.addSubviews([writeContentView])
        writeContentView.addSubviews([selectMusicLabel, searchButton, firstTimeMusicLabel, firstListenButton, againListenButton, impressionLabel, impressionTagCV, feelLabel, feelTagScrollView, contentLabel, contentTextView, isPrivateToggleButton, privateLabel, countTextViewLabel])
        feelTagScrollView.addSubview(feelTagCV)
        
        naviView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        writeScrollView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        writeContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        selectMusicLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.height.equalTo(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(selectMusicLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40.adjustedH)
        }
        
        firstTimeMusicLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        firstListenButton.snp.makeConstraints {
            $0.top.equalTo(firstTimeMusicLabel.snp.bottom).offset(16)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(163.adjustedW)
            $0.height.equalTo(40.adjustedH)
        }
        
        againListenButton.snp.makeConstraints {
            $0.top.equalTo(firstListenButton.snp.top)
            $0.width.height.equalTo(firstListenButton)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        impressionLabel.snp.makeConstraints {
            $0.top.equalTo(againListenButton.snp.bottomMargin).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        impressionTagCV.snp.makeConstraints {
            $0.top.equalTo(impressionLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().inset(70)
            $0.height.equalTo(tagCellHeight * 2 + cellVerticalSpacing)
        }
        
        feelLabel.snp.makeConstraints {
            $0.top.equalTo(impressionTagCV.snp.bottomMargin).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        feelTagScrollView.snp.makeConstraints {
            $0.top.equalTo(feelLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(tagCellHeight * 3 + cellVerticalSpacing * 2)
        }
        
        feelTagCV.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(550)
            $0.height.equalTo(tagCellHeight * 3 + cellVerticalSpacing * 2)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(feelTagScrollView.snp.bottomMargin).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottomMargin).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(252.adjustedH)
        }
        
        countTextViewLabel.snp.makeConstraints {
            $0.right.equalTo(contentTextView.snp.right).inset(13)
            $0.bottom.equalTo(contentTextView.snp.bottom).inset(15)
        }
        
        isPrivateToggleButton.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottomMargin).offset(15)
            $0.right.equalToSuperview().inset(20)
            $0.width.equalTo(49)
            $0.height.equalTo(28)
            $0.bottom.equalToSuperview().inset(45)
        }
        
        privateLabel.snp.makeConstraints {
            $0.centerY.equalTo(isPrivateToggleButton)
            $0.right.equalToSuperview().inset(78.adjustedW)
        }
    }
}
