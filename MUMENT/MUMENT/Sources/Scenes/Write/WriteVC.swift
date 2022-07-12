//
//  WriteVC.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import SnapKit
import Then

class WriteVC: BaseVC {
    
    // MARK: - Properties
    private let writeScrollView = UIScrollView().then {
        $0.bounces = false
    }
    private let writeContentView = UIView().then {
        $0.backgroundColor = .mBgwhite
    }
    private let naviView = DefaultNavigationView().then {
        $0.setTitleLabel(title: "기록하기")
    }
    private let resetButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "mumentReset"), for: .normal)
    }
    private let selectMusicLabel = UILabel().then {
        $0.text = "곡을 선택해주세요."
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let searchButton = UIButton(type: .system).then {
        $0.setTitle("곡, 아티스트 검색", for: .normal)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.titleLabel?.font = .mumentB4M14
        $0.backgroundColor = .mGray5
        $0.layer.cornerRadius = 10
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "mumentSearch")
        $0.configuration?.imagePadding = 10
        $0.contentHorizontalAlignment = .left
    }
    private let firstTimeMusicLabel = UILabel().then {
        $0.text = "처음 들은 곡인가요?"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let firstTimeButton = UIButton(type: .system).then {
        $0.setTitle("처음 들어요", for: .normal)
        $0.setBackgroundColor(.mBlue3, for: .selected)
        $0.setBackgroundColor(.mGray5, for: .normal)
        $0.setTitleColor(.mBlue1, for: .selected)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.makeRounded(cornerRadius: 11.adjustedH)
    }
    private let alreadyKnowButton = UIButton(type: .system).then {
        $0.setTitle("다시 들었어요", for: .normal)
        $0.setBackgroundColor(.mBlue3, for: .selected)
        $0.setBackgroundColor(.mGray5, for: .normal)
        $0.setTitleColor(.mBlue1, for: .selected)
        $0.setTitleColor(.mGray1, for: .normal)
        $0.makeRounded(cornerRadius: 11.adjustedH)
    }
    private let impressiveLabel = UILabel().then {
        $0.text = "무엇이 인상적이었나요?"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let impressiveTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
    }
    private let feelLabel = UILabel().then {
        $0.text = "감정을 선택해보세요."
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let feelTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
    }
    private let completeButton = MumentCompleteButton(isEnabled: true).then {
        $0.setTitle("완료", for: .normal)
    }
    
    var clickedImpressiveTag: [Int] = []
    var clickedFeelTag: [Int] = []
    var impressiveTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브"]
    var feelTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브", "🎡 벅참", "😄 신남", " 💐 설렘", "🗯 스트레스"]
    
    private let tagCellHeight = 35.adjustedH
    private let cellVerticalSpacing = 10.adjustedW
    private let CVLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 20
        $0.sectionInset = .zero
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTagCV()
        setLayout()
        setRadioButtonSelectStatus(button: firstTimeButton, isSelected: false)
        setRadioButtonSelectStatus(button: alreadyKnowButton, isSelected: true)
        setRadioButton()
        registerCell()
    }
    
    // MARK: - Functions
    private func setRadioButton() {
        firstTimeButton.press {
            self.setRadioButtonSelectStatus(button: self.firstTimeButton, isSelected: true)
            self.setRadioButtonSelectStatus(button: self.alreadyKnowButton, isSelected: false)
        }
        alreadyKnowButton.press {
            self.setRadioButtonSelectStatus(button: self.firstTimeButton, isSelected: false)
            self.setRadioButtonSelectStatus(button: self.alreadyKnowButton, isSelected: true)
        }
    }
    
    private func setTagCV() {
        impressiveTagCV.dataSource = self
        impressiveTagCV.delegate = self
        impressiveTagCV.layoutMargins =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        impressiveTagCV.allowsMultipleSelection = true
        impressiveTagCV.clipsToBounds = true
        impressiveTagCV.collectionViewLayout = CVLayout
        
        feelTagCV.dataSource = self
        feelTagCV.delegate = self
        feelTagCV.layoutMargins =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        feelTagCV.allowsMultipleSelection = true
        feelTagCV.clipsToBounds = true
        feelTagCV.collectionViewLayout = CVLayout
    }
}

// MARK: - UI
extension WriteVC {
    
    private func setRadioButtonSelectStatus(button: UIButton, isSelected: Bool) {
        button.isSelected = isSelected
        button.titleLabel?.font = isSelected ? .mumentB3B14 : .mumentB4M14
    }
    
    private func registerCell() {
        impressiveTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
        feelTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
    }
    
    private func setLayout() {
        view.addSubviews([writeScrollView])
        writeScrollView.addSubviews([writeContentView])
        writeContentView.addSubviews([naviView, resetButton, selectMusicLabel, searchButton, firstTimeMusicLabel, firstTimeButton, alreadyKnowButton, impressiveLabel, impressiveTagCV, feelLabel, feelTagCV])
        
        writeScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        writeContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        naviView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(52.adjustedH)
        }
        
        resetButton.snp.makeConstraints {
            $0.centerY.equalTo(naviView)
            $0.width.height.equalTo(25.adjustedW)
            $0.rightMargin.equalToSuperview().inset(20)
        }
        
        selectMusicLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(40)
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
        
        firstTimeButton.snp.makeConstraints {
            $0.top.equalTo(firstTimeMusicLabel.snp.bottom).offset(16)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(163.adjustedW)
            $0.height.equalTo(40.adjustedH)
        }
        
        alreadyKnowButton.snp.makeConstraints {
            $0.top.equalTo(firstTimeButton.snp.top)
            $0.width.height.equalTo(firstTimeButton)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        impressiveLabel.snp.makeConstraints {
            $0.top.equalTo(alreadyKnowButton.snp.bottomMargin).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        impressiveTagCV.snp.makeConstraints {
            $0.top.equalTo(impressiveLabel.snp.bottom).offset(16)
            $0.left.equalTo(impressiveLabel.snp.left)
            $0.right.equalToSuperview()
            $0.height.equalTo(tagCellHeight * 2 + Double(cellVerticalSpacing))
        }
        
        feelLabel.snp.makeConstraints {
            $0.top.equalTo(impressiveTagCV.snp.bottomMargin).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        feelTagCV.snp.makeConstraints {
            $0.top.equalTo(feelLabel.snp.bottom).offset(16)
            $0.left.equalTo(feelLabel.snp.left)
            $0.right.equalToSuperview()
            $0.height.equalTo(tagCellHeight * 2 + Double(cellVerticalSpacing))
            $0.bottom.equalToSuperview()
        }
// TODO: 컬렉션뷰 진짜 개모르겠다. 말렸다. ㅋ  종일 햇는데 컬렉션뷰에 잡아먹힌 기분이다. 나중에 할 거다. 며칠만 뒤에... 뇌를 좀 상쾌하게 바꾸고 다시 도전한다 .....................
// MARK: - UICollectionViewDataSource
extension WriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case impressiveTagCV:
            return impressiveTagDummyData.count
        case feelTagCV:
            return feelTagDummyData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteTagCVC.className, for: indexPath) as! WriteTagCVC
        switch collectionView {
        case impressiveTagCV:
            cell.setData(data: impressiveTagDummyData[indexPath.row])
            return cell
        case feelTagCV:
            cell.setData(data: feelTagDummyData[indexPath.row])
            return cell
        default: return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WriteVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizingCell = WriteTagCVC()
        switch collectionView {
        case impressiveTagCV:
            sizingCell.setData(data: impressiveTagDummyData[indexPath.row])
        case feelTagCV:
            sizingCell.setData(data: feelTagDummyData[indexPath.row])
        default: break
        }
        
        sizingCell.contentLabel.sizeToFit()
        
        let cellWidth = sizingCell.contentLabel.frame.width + 26
        let cellHeight = tagCellHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
            cell.isSelected = true
        }
        debugPrint("cell clicked", "\(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
            cell.isSelected = false
        }
        debugPrint("cell Unclicked", "\(indexPath)")
    }
}
