//
//  StorageFilterVC.swift
//  MUMENT
//
//  Created by 김담인 on 2023/01/22.
//

import UIKit
import SnapKit
import Then

protocol storageFilterDelegate: AnyObject {
    func sendButtonData(data:[TagButton])
}

final class StorageFilterVC: BaseVC {
    
    // MARK: - Components
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.mBgwhite
    }
    private let bottomSheetTitle = UILabel().then {
        $0.setLabel(text: "필터", color: UIColor.mBlack2, font: UIFont.mumentH2B18)
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = UIColor.mGray3
    }
    let dismissButton = UIButton().then {
        $0.setImage(UIImage(named: "mumentDelete"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    private let impressionLabel = UILabel().then {
        $0.text = "인상적인 부분"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let feelLabel = UILabel().then {
        $0.text = "감정"
        $0.font = .mumentB1B15
        $0.textColor = .mBlack2
    }
    private let selectedTagsCountLabel = UILabel()
    
    var tagCount: String = " " {
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
    
    private let tagAppliedButton = UIButton().then {
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
        $0.distribution = .fillProportionally
    }
    
    private let selectedTagsCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .mGray3
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 0
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.height = 35
        $0.setCollectionViewLayout(layout, animated: false)
    }
    
    // MARK: - Properties
    private let containerHeight = NSLayoutConstraint()
    private let impressionTagData = TagList().impressionTags
    private let feelTagData = TagList().feelTags
    
    private lazy var impressionTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var feelTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var selectedTagCount = 0
    private var bottomTagSectionHeight = 0
    private var selectedTagButtons = [TagButton]()
    private var tempSelectedTagButtons = [TagButton]()
    private var selectedTagDictionay = [Int : Int]()
    private var tagIndex = [Int]()
    weak var delegate: storageFilterDelegate?
    
    ///for SelectedTag
    private var selectedTagData: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTagCV()
        registerCell()
        
        setDismissButtonAction()
        tagCount = "\(selectedTagCount)"
        setAllDeselectAction()
        setFilterTagApplied()
        
        setNaviUI()
        setCVLayout()
        setBottomLayout()
        setFilterTagLayout()
    }
    
    // MARK: - Function
    private func setDismissButtonAction() {
        dismissButton.press {
            self.delegate?.sendButtonData(data: self.tempSelectedTagButtons)
            self.hideBottomSheetWithAnimation()
        }
    }
    
    private func setTagCV() {
        [impressionTagCV, feelTagCV].forEach {
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .mBgwhite
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.layoutMargins = .zero
            $0.allowsMultipleSelection = true
            $0.clipsToBounds = true
        }
        impressionTagCV.collectionViewLayout = FilterLayout(layoutType: .impression)
        feelTagCV.collectionViewLayout = FilterLayout(layoutType: .feel)
        
        selectedTagsCV.dataSource = self
        selectedTagsCV.delegate = self
    }
    
    private func registerCell() {
        impressionTagCV.register(cell: StorageFilterTagCVC.self, forCellWithReuseIdentifier: StorageFilterTagCVC.className)
        feelTagCV.register(cell: StorageFilterTagCVC.self, forCellWithReuseIdentifier: StorageFilterTagCVC.className)
        selectedTagsCV.register(cell: SelectedTagCVC.self, forCellWithReuseIdentifier: SelectedTagCVC.className)
    }
    
    // TagButton 인스턴스 생성
    /// selectedTagButtons 배열에 인스턴스 append
    /// selectedTagButtons 배열 count번째의 버튼에
    private func buttonAppend(_ count: Int, _ tagTitle: String) {
        let filterTagButton = TagButton()
        selectedTagButtons.append(filterTagButton)
        //        selectedTagButtons[count].setTagButtonTitle(tagTitle)
    }
    
    private func setAllDeselectAction() {
        allDeselecteButton.press {
            self.selectedTagButtons = []
            self.selectedTagDictionay = [:]
            self.tagIndex = []
            self.selectedTagsStackView.removeAllArrangedSubviews()
            self.tagCount = "0"
            self.selectedTagCount = 0
            self.impressionTagCV.reloadData()
            self.feelTagCV.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                self.selectedTagsSection.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
            }
        }
    }
    
    private func setFilterTagApplied() {
        tagAppliedButton.press {
            self.delegate?.sendButtonData(data: self.selectedTagButtons)
            self.hideBottomSheetWithAnimation()
        }
    }
    
    func setTempTagButtons(tags: [TagButton]) {
        self.tempSelectedTagButtons = tags
    }
    
}

// MARK: - BottomSheet Animation
extension StorageFilterVC {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.containerHeight.constant = UIScreen.main.bounds.height >= 670 ? 690.adjustedH : 750.adjustedH
            self.containerView.snp.updateConstraints {
                $0.height.equalTo(self.containerHeight.constant)
            }
            self.view.layoutIfNeeded()
        }
        //TODO: 바텀시트 하단 선택 태그 UI 업데이트
        selectedTagButtons.forEach {
            self.selectedTagsStackView.removeArrangedSubview($0)
        }
        
        selectedTagButtons.forEach {
            self.selectedTagsStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(35)
            }
        }
        self.selectedTagsStackView.layoutIfNeeded()
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
extension StorageFilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case impressionTagCV:
            return impressionTagData.count
        case feelTagCV:
            return feelTagData.count
        case selectedTagsCV:
            print("cellForItem", selectedTagData.count)
             return selectedTagData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case impressionTagCV:
            let filterTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageFilterTagCVC.className, for: indexPath) as! StorageFilterTagCVC
            filterTagCell.setData(data: impressionTagData[indexPath.row])
            return filterTagCell
        case feelTagCV:
            let filterTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageFilterTagCVC.className, for: indexPath) as! StorageFilterTagCVC
            filterTagCell.setData(data: feelTagData[indexPath.row])
            return filterTagCell
        case selectedTagsCV:
            let selectedTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedTagCVC.className, for: indexPath) as! SelectedTagCVC
            selectedTagCell.setTagButtonTitle(selectedTagData[indexPath.row])
            print("cellForItem",selectedTagData)
            print("cellForItemTItle ", selectedTagData[indexPath.row])
            print("cellForItemTItle ", indexPath.row)
            return selectedTagCell
        default: return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension StorageFilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("111")
        switch collectionView {
        case impressionTagCV:
            if selectedTagCount < 3 {
                selectedTagCount += 1
                tagCount = "\(selectedTagCount)"
                
                selectedTagData.append(impressionTagData[indexPath.row])
                tagIndex.append(indexPath.row)
//                self.selectedTagsCV.reloadData()
                print("DDtagData", selectedTagData)
                print("DDindex", tagIndex)
            }else {
                collectionView.deselectItem(at: indexPath, animated: false)
                self.showToastMessage(message: "태그는 최대 3개까지 선택할 수 있어요.", color: .black)
            }
            
        case feelTagCV:
            if selectedTagCount < 3 {
                selectedTagCount += 1
                tagCount = "\(selectedTagCount)"
                
                selectedTagData.append(feelTagData[indexPath.row])
                tagIndex.append(indexPath.row + 100)
               
            }else {
                collectionView.deselectItem(at: indexPath, animated: false)
                self.showToastMessage(message: "태그는 최대 3개까지 선택할 수 있어요.", color: .black)
            }
            
        case selectedTagsCV:
            
            var deselectedTagIndex = tagIndex[indexPath.row]
            var deselctedCV = impressionTagCV
            /// feelTagCV값이면 마이너스 100
            if deselectedTagIndex >= 100 {
                deselectedTagIndex -= 100
                deselctedCV = feelTagCV
            }
            let deselectedIndexPath = IndexPath(row: deselectedTagIndex, section: 0)
            print("DDremoveTagData ", selectedTagData[indexPath.row])
            print("DDremoveTagIndex ", tagIndex[indexPath.row])
            selectedTagData.remove(at: indexPath.row)
            tagIndex.remove(at: indexPath.row)
            
            self.collectionView(deselctedCV, didDeselectItemAt: deselectedIndexPath)
            selectedTagsCV.reloadData()
            
        default: break
        }
  
        if tagIndex.count != 0 {
            bottomTagSectionHeight = 70
            UIView.animate(withDuration: 0.3) {
                self.selectedTagsCV.snp.updateConstraints {
                    $0.height.equalTo(self.bottomTagSectionHeight)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(10)){
            self.selectedTagsCV.reloadData()
            print("reload")
        }
        print("selectedTagData",selectedTagData)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if selectedTagCount > 0 {
            selectedTagCount = selectedTagCount - 1
        }
        tagCount = "\(selectedTagCount)"
        collectionView.deselectItem(at: indexPath, animated: false)

        var indexOfArray = 0
        switch collectionView {
        case impressionTagCV:
            // TODO: 함수화 하기
            tagIndex.forEach {
                if $0 == indexPath.row {
                    indexOfArray = tagIndex.firstIndex(of: $0) ?? 0
                    selectedTagData.remove(at: indexOfArray)
                    tagIndex.remove(at: indexOfArray)
                    
                }
            }
            
        case feelTagCV:
            tagIndex.forEach {
                if $0 == indexPath.row + 100 {
                    indexOfArray = tagIndex.firstIndex(of: $0) ?? 0
                    selectedTagData.remove(at: indexOfArray)
                    tagIndex.remove(at: indexOfArray)
                    
                }
            }
          
        default: break
        }

        if tagIndex.count == 0 {
            selectedTagData = []
            tagIndex = []
            bottomTagSectionHeight = 0
            UIView.animate(withDuration: 0.3) {
                self.selectedTagsCV.snp.updateConstraints {
                    $0.height.equalTo(self.bottomTagSectionHeight)
                }
            }
        }
        selectedTagsCV.reloadData()
        print("selectedTagData",selectedTagData)
    }
}

extension StorageFilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("cellForItemSize", CGSize(width: selectedTagData[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.mumentB2B14]).width + 45, height: 35) )
        return CGSize(width: selectedTagData[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.mumentB2B14]).width + 45, height: 35)
    }
}

// MARK: - UI
extension StorageFilterVC {
    private func setNaviUI() {
        self.view.backgroundColor = UIColor.mAlertBgBlack
        
        view.addSubView(containerView)
        
        /// 동적 높이
        containerHeight.constant = UIScreen.main.bounds.height - 100
        
        containerView.snp.makeConstraints{
            $0.height.equalTo(containerHeight.constant)
            //            $0.width.equalToSuperview()
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        containerView.layer.cornerRadius = 11
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        containerView.addSubViews([dismissButton, bottomSheetTitle, underLineView, selectedTagsCountLabel])
        
        dismissButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(3)
            $0.top.equalToSuperview().inset(9)
            $0.height.width.equalTo(48)
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
    
    private func setCVLayout() {
        containerView.addSubviews([impressionLabel, impressionTagCV, feelLabel, feelTagCV])
        
        impressionLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(45.adjustedH)
            $0.left.equalToSuperview().inset(22)
            $0.height.equalTo(16)
        }
        
        impressionTagCV.snp.makeConstraints {
            $0.top.equalTo(impressionLabel.snp.bottom).offset(16.adjustedH)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        feelLabel.snp.makeConstraints {
            $0.top.equalTo(impressionTagCV.snp.bottom).offset(21.adjustedH)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(19)
        }
        
        feelTagCV.snp.makeConstraints {
            $0.top.equalTo(feelLabel.snp.bottom).offset(16.adjustedH)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(225.adjustedH)
        }
    }
    
    private func setBottomLayout() {
        containerView.addSubViews([tagAppliedButton, allDeselecteButton])
        
        tagAppliedButton.snp.makeConstraints {
            $0.top.equalTo(feelTagCV.snp.bottom).offset(15.adjustedH)
            $0.right.equalToSuperview().inset(20)
            $0.width.equalTo(143)
            $0.height.equalTo(45.adjustedH)
        }
        
        allDeselecteButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(19)
            $0.centerY.equalTo(tagAppliedButton)
            $0.height.equalTo(26)
        }
    }
    
    private func setFilterTagLayout() {
        containerView.addSubView(selectedTagsCV)
        
        selectedTagsCV.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(tagAppliedButton.snp.bottom).offset(20.adjustedH)
            $0.height.equalTo(bottomTagSectionHeight)
        }
    }
}
