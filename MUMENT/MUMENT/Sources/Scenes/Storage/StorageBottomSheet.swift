//
//  StorageBottomSheet.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/18.
//

import UIKit
import SnapKit
import Then

class StorageBottomSheet: UIViewController {

    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.mBgwhite
    }
    private let containerHeight = NSLayoutConstraint()
    let dismissButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentDelete"), for: .normal)
    }
    private let bottomSheetTitle = UILabel().then {
        $0.setLabel(text: "필터", color: UIColor.mBlack2, font: UIFont.mumentH2B18)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = UIColor.mGray3
    }
    
    var isDismissed = true
    
    private let selectedTagsCount = 1
    
    private let selectedTagsCountLabel = UILabel().then {
        $0.setLabel(text: "", font: UIFont.mumentB4M14)
    }
    
    var tagCount: String = "" {
        didSet{
            let highlitedString = NSAttributedString(string: tagCount, attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mBlue1
            ])
            
            let normalString = NSAttributedString(string: " / 3", attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mGray1
            ])
            
            let title = highlitedString + normalString
            selectedTagsCountLabel.attributedText = title
        }
    }
    
    // MARK: - Tag View
    private let impressionLabel = UILabel().then {
        $0.text = "인상적인 부분"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    
    private let impressionTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets.zero
    }
    
    private let feelLabel = UILabel().then {
        $0.text = "감정"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }

    private let feelTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mBgwhite
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    var impressionTagData = ["🎙 음색", "🎶 멜로디", "🥁 비트", "🎸 베이스", "🖋 가사", "🛫 도입부"]
    var feelTagData = ["🎡 벅참", "🍁 센치함", "⌛️ 아련함", "😄 신남", "😔 우울", "💭 회상", "💐 설렘", "🕰 그리움", " 👥 위로", "😚 행복", "🛌 외로움", "🌅 낭만", "🙌 자신감", "🌋 스트레스", "☕️ 차분", "🍀 여유로움"]
    
    var clickedTagArray: [Int] = Array(repeating: 0, count: 22)
    var selectedTagCount = 0

    private let tagCellHeight = 37
    private let cellVerticalSpacing = 10
    private let leftCVLayout = LeftAlignedCollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.sectionInset = .zero
    }
    
    private let setTagFilterButton = UIButton().then {
        $0.setTitle("태그 적용하기", for: .normal)
        $0.titleLabel?.font = UIFont.mumentB2B14
        $0.setTitleColor(UIColor.mWhite, for: .normal)
        $0.setBackgroundColor(UIColor.mPurple1, for: .normal)
        $0.makeRounded(cornerRadius: 11)
    }
    private let allDeselecteButton = UIButton().then {
        $0.setImage(UIImage(named: "allDeselectedButton"), for: .normal)
    }
    
    private let selectedTagsSection = UIView().then {
        $0.backgroundColor = .mGray3
    }
    
    private let selectedTagsStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 10
        $0.axis = .horizontal
        $0.alignment = .leading
    }

    
    private let emptySelectedTag = UIButton().then {
        $0.backgroundColor = .brown
    }
    
    var selectedTagButtons = [TagButton]()
    var selectedTagDictionay = [Int : Int]()
    var tagIndex = [Int]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviUI()
        setCVLayout()
        setBottomLayout()
        setDismissButtonAction()
        tagCount = "\(selectedTagCount)"
        
        setTagCV()
        registerCell()
        setFilterTagLayout()
    }

    private func setDismissButtonAction() {
        dismissButton.press {
            self.isDismissed = true
            self.hideBottomSheetWithAnimation()
        }
    }
    
    private func setTagCV() {
        impressionTagCV.dataSource = self
        impressionTagCV.delegate = self
        impressionTagCV.layoutMargins = .zero
        impressionTagCV.allowsMultipleSelection = true
        impressionTagCV.clipsToBounds = true
//        impressionTagCV.collectionViewLayout = leftCVLayout
        
        feelTagCV.dataSource = self
        feelTagCV.delegate = self
        feelTagCV.layoutMargins = .zero
        feelTagCV.allowsMultipleSelection = true
        feelTagCV.clipsToBounds = true
        feelTagCV.collectionViewLayout = leftCVLayout
    }
    
    private func registerCell() {
        impressionTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
        feelTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
    }
    
    // TagButton 인스턴스 생성
    // selectedTagButtons 배열에 인스턴스 append
    // selectedTagButtons 배열 count번째의 버튼에
    private func buttonAppend(_ count: Int, _ tagTitle: String) {
        let filterTagButton = TagButton()
        selectedTagButtons.append(filterTagButton)
        selectedTagButtons[count].setTitle(tagTitle, for: .normal)
        self.setTagFilterButton.layoutIfNeeded()
    }
}

// MARK: - Set UI
extension StorageBottomSheet {
    private func setNaviUI() {
        self.view.backgroundColor = UIColor.mAlertBgBlack
        
        view.addSubViews([containerView])
        
        containerHeight.constant = 0
        
        containerView.snp.makeConstraints{
            $0.height.equalTo(containerHeight.constant)
            $0.width.equalTo(view.frame.width)
            $0.left.right.bottom.equalToSuperview()
        }
        containerView.layer.cornerRadius = 11
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        containerView.addSubViews([dismissButton, bottomSheetTitle, underLineView, selectedTagsCountLabel])
        
        dismissButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(20)
            $0.height.equalTo(25)
        }
        
        bottomSheetTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(containerView.snp.top).inset(20)
            $0.height.equalTo(24)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetTitle.snp.bottom).offset(10)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        selectedTagsCountLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
        }
    }
}

// MARK: - BottomSheet Animation
extension StorageBottomSheet {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 699.adjustedH
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = 0
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension StorageBottomSheet: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension StorageBottomSheet: UICollectionViewDelegateFlowLayout {
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
       
        if selectedTagCount < 3 {
            if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
                cell.isSelected = true
                selectedTagCount += 1
                tagCount = "\(selectedTagCount)"
            }
            switch collectionView {
            case impressionTagCV:
                clickedTagArray[indexPath.row] = indexPath.row + 100
                                
                buttonAppend(selectedTagCount - 1, impressionTagData[indexPath.row])
                // key가 태그 번호, value가 선택된 태그 인덱스 번호 0, 1, 2
                selectedTagDictionay[indexPath.row] = selectedTagCount - 1
                
                tagIndex.append(indexPath.row)
                
            case feelTagCV:
                clickedTagArray[indexPath.row + 6] = indexPath.row + 200

                buttonAppend(selectedTagCount - 1, feelTagData[indexPath.row])
                // impressionTag번호와 다르게 구분하기 위해 + 100
                selectedTagDictionay[indexPath.row + 100] = selectedTagCount - 1
                
                tagIndex.append(indexPath.row + 100)

            default: break
            }
            
            self.selectedTagsStackView.removeArrangedSubview(emptySelectedTag)
            selectedTagButtons.forEach {
                self.selectedTagsStackView.removeArrangedSubview($0)
            }
            
            selectedTagButtons.forEach {
                self.selectedTagsStackView.addArrangedSubview($0)
                
                $0.snp.makeConstraints {
                    $0.height.equalTo(35)
                    $0.width.equalTo(89)
                }
            }
            self.selectedTagsStackView.addArrangedSubview(emptySelectedTag)
            self.selectedTagsStackView.layoutIfNeeded()

        }else {
            collectionView.deselectItem(at: indexPath, animated: false)
            // TODO: 3개 제한 알림창 구현
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? WriteTagCVC {
            cell.isSelected = false
            selectedTagCount -= 1
            tagCount = "\(selectedTagCount)"
        }
        switch collectionView {
        case impressionTagCV:
            
            clickedTagArray[indexPath.row] = 0
            debugPrint("impression", selectedTagDictionay[indexPath.row]!)
            selectedTagButtons.remove(at: selectedTagDictionay[indexPath.row]!)
            tagIndex.remove(at: selectedTagDictionay[indexPath.row]!)
            debugPrint("remov1",selectedTagDictionay[indexPath.row]!)

        case feelTagCV:
            
            clickedTagArray[indexPath.row + 6] = 0
            debugPrint("feel", selectedTagDictionay[indexPath.row + 100]!)
            
            selectedTagButtons.forEach {
                self.selectedTagsStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            selectedTagButtons.remove(at: selectedTagDictionay[indexPath.row + 100]!)
            tagIndex.remove(at: selectedTagDictionay[indexPath.row + 100]!)
            
        default: break
        }
        
        var count = 0
        tagIndex.forEach {
            selectedTagDictionay[$0] = count
            count += 1
        }
        
        self.selectedTagsStackView.removeArrangedSubview(emptySelectedTag)
        emptySelectedTag.removeFromSuperview()
        

        
        selectedTagButtons.forEach {
            self.selectedTagsStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(35)
                $0.width.equalTo(89)
            }
        }
        self.selectedTagsStackView.addArrangedSubview(emptySelectedTag)
        
        self.selectedTagsStackView.layoutIfNeeded()
    }
}

// MARK: - BottomSheetTagView
extension StorageBottomSheet {
    func setCVLayout() {
        containerView.addSubviews([impressionLabel, impressionTagCV, feelLabel, feelTagCV])
    
        impressionLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(45.adjustedH)
            $0.left.equalToSuperview().inset(22)
            $0.height.equalTo(16)
        }
        
        impressionTagCV.snp.makeConstraints {
            $0.top.equalTo(impressionLabel.snp.bottom).offset(16.adjustedH)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(86)
            $0.height.equalTo(tagCellHeight * 2 + cellVerticalSpacing)
        }
        
        feelLabel.snp.makeConstraints {
            $0.top.equalTo(impressionTagCV.snp.bottom).offset(23.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(19)
        }
        
        feelTagCV.snp.makeConstraints {
            $0.top.equalTo(feelLabel.snp.bottom).offset(16.adjustedH)
            $0.left.equalToSuperview().inset(10.adjustedW)
            if UIScreen.main.bounds.height >= 800 {
                $0.right.equalToSuperview().inset(19.adjustedW)
                $0.height.equalTo(tagCellHeight * 5 + cellVerticalSpacing * 4)
            }else {
                $0.right.equalToSuperview()
                $0.height.equalTo(tagCellHeight * 4 + cellVerticalSpacing * 3)
            }
            $0.width.equalTo(containerView.frame.width - 20)
        }
    }
    
    func setBottomLayout() {
        containerView.addSubViews([setTagFilterButton, allDeselecteButton, selectedTagsSection, selectedTagsStackView])
        
        setTagFilterButton.snp.makeConstraints {
            $0.top.equalTo(feelTagCV.snp.bottom).offset(20.adjustedH)
            $0.right.equalToSuperview().inset(20)
            $0.width.equalTo(143)
            $0.height.equalTo(45.adjustedH)
        }
        
        allDeselecteButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(19)
            $0.centerY.equalTo(setTagFilterButton)
            $0.height.equalTo(26)
        }
    }
    func setFilterTagLayout() {
        selectedTagsSection.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(setTagFilterButton.snp.bottom).offset( 20.adjustedH)
            $0.bottom.equalToSuperview()
        }
        
        selectedTagsStackView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(selectedTagsSection).offset(14.adjustedH)
            $0.right.equalTo(selectedTagsSection.snp.right)
            $0.height.equalTo(tagCellHeight)
        }
        
        selectedTagButtons.forEach {
            self.selectedTagsStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(35)
//                $0.left.equalTo(T##other: ConstraintRelatableTarget##ConstraintRelatableTarget)
            }
        }
        
        selectedTagsStackView.addArrangedSubview(emptySelectedTag)
    }
}