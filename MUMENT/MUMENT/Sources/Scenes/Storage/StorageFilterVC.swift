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
    func sendTagData(data:[String], tagIndex:[Int])
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
    private let dismissButton = UIButton().then {
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
    
    private var tagCount: String = " " {
        didSet{
            let highlighttedString = NSAttributedString(string: tagCount, attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mBlue1
            ])
            
            let normalString = NSAttributedString(string: " / 3", attributes: [
                .font: UIFont.mumentB4M14,
                .foregroundColor: UIColor.mGray1
            ])
            
            let title = highlighttedString + normalString
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
    private let impressionTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let feelTagCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Properties
    private let containerHeight = NSLayoutConstraint()
    private let impressionTagData = TagList().impressionTags
    private let feelTagData = TagList().feelTags
    private var selectedTagCount = 0
    private var bottomTagSectionHeight = 0
    private var selectedTagData: [String] = []
    private var tagIndex = [Int]()
    weak var delegate: storageFilterDelegate?
    
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

    private func resetSelectedTags() {
        self.tagCount = "0"
        self.selectedTagCount = 0
        self.impressionTagCV.reloadData()
        self.feelTagCV.reloadData()
        self.selectedTagData = []
        self.tagIndex = []
        self.selectedTagsCV.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.selectedTagsCV.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
    }
    
    private func setAllDeselectAction() {
        allDeselecteButton.press {
            self.resetSelectedTags()
        }
    }
    
    private func setFilterTagApplied() {
        tagAppliedButton.press {
            self.delegate?.sendTagData(data: self.selectedTagData, tagIndex: self.tagIndex)
            self.hideBottomSheetWithAnimation()
        }
    }

    func setAppliedTagData(tags: [String], tagIndex: [Int]) {
        self.selectedTagData = tags
        self.tagIndex = tagIndex
        selectedTagCount = selectedTagData.count
        tagCount = "\(selectedTagCount)"
        
        impressionTagCV.reloadData()
        feelTagCV.reloadData()
        
        if tagIndex.count != 0 {
            bottomTagSectionHeight = 70
            UIView.animate(withDuration: 0.3) {
                self.selectedTagsCV.snp.updateConstraints {
                    $0.height.equalTo(self.bottomTagSectionHeight)
                }
            }
            selectedTagsCV.reloadData()
        }
    }
    
}

// MARK: - BottomSheet Animation
extension StorageFilterVC {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.4) {
            self.containerHeight.constant = UIScreen.main.bounds.height >= 670 ? 690.adjustedH : 750.adjustedH
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
            self.resetSelectedTags()
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
             return selectedTagData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case impressionTagCV:
            let filterTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageFilterTagCVC.className, for: indexPath) as! StorageFilterTagCVC
            filterTagCell.setData(data: impressionTagData[indexPath.row])
            tagIndex.forEach {
                if $0 == indexPath.item {
                    collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                    filterTagCell.isSelected = true
                }
            }
            return filterTagCell
        case feelTagCV:
            let filterTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageFilterTagCVC.className, for: indexPath) as! StorageFilterTagCVC
            filterTagCell.setData(data: feelTagData[indexPath.row])
            tagIndex.forEach {
                if $0 == indexPath.item + 100 {
                    collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                    filterTagCell.isSelected = true
                }
            }
            return filterTagCell
        case selectedTagsCV:
            let selectedTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedTagCVC.className, for: indexPath) as! SelectedTagCVC
            selectedTagCell.setTagButtonTitle(selectedTagData[indexPath.row])
            return selectedTagCell
        default: return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension StorageFilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case impressionTagCV, feelTagCV:
            if selectedTagCount < 3 {
                selectedTagCount += 1
                tagCount = "\(selectedTagCount)"
                /// 해당 컬렉션뷰가 feelTagCV이면 indexPath.row + 100
                let selectedIndex = collectionView == impressionTagCV ? indexPath.row : indexPath.row + 100
                if selectedIndex < 100 {
                    selectedTagData.append(impressionTagData[indexPath.row])
                }else {
                    selectedTagData.append(feelTagData[indexPath.row])
                }
                tagIndex.append(selectedIndex)
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
        /// 그냥 reloadData() 실행 시 numberOfItemsInSectionItems만 실행되고, sizeForItemAt과 cellForItemAt이 실행되지 않음
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(10)){
            self.selectedTagsCV.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if selectedTagCount > 0 {
            selectedTagCount = selectedTagCount - 1
        }
        tagCount = "\(selectedTagCount)"
        collectionView.deselectItem(at: indexPath, animated: false)

        var indexOfArray = 0
        switch collectionView {
        case impressionTagCV, feelTagCV:
            let selectedIndex = collectionView == impressionTagCV ? indexPath.row : indexPath.row + 100
            tagIndex.forEach {
                if $0 == selectedIndex {
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
    }
}

extension StorageFilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedTagData.isEmpty {
            return CGSize()
        }
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
