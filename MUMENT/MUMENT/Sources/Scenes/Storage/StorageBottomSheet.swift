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
        $0.setLabel(text: "필터", font: UIFont.mumentH2B18)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = UIColor.mGray3
    }
    
    var isDismissed = true
    
    private let selectedTagsCount = 1
    
    private let selectedTagsCountLabel = UILabel().then {
        $0.setLabel(text: "test", font: UIFont.mumentB4M14)
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
    
    var clickedTag: [Int] = []
    
    var impressionTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브"]
    var feelTagDummyData = ["🥁 비트", "🛫 도입부", "🎙 음색", "🎶 멜로디", "🎉 클라이막스", "💃 그루브", "🎡 벅참", "😄 신남", " 💐 설렘", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스", "🗯 스트레스"]
    
    private let tagCellHeight = 37
    private let cellVerticalSpacing = 10
    private let CVLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.sectionInset = .zero
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviUI()
        setDismissButtonAction()
        tagCount = "1"
        
        setTagCV()
        registerCell()
        setCVLayout()
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
        impressionTagCV.collectionViewLayout = CVLayout
        
        feelTagCV.dataSource = self
        feelTagCV.delegate = self
        feelTagCV.layoutMargins = .zero
        feelTagCV.allowsMultipleSelection = true
        feelTagCV.clipsToBounds = true
        feelTagCV.collectionViewLayout = CVLayout
    }
    
    private func registerCell() {
        impressionTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
        feelTagCV.register(cell: WriteTagCVC.self, forCellWithReuseIdentifier: WriteTagCVC.className)
    }
}

// MARK: - UI
extension StorageBottomSheet {
    private func setNaviUI() {
        /// 백그라운드 그레이로 수정
        self.view.backgroundColor = UIColor.mBlue1
        
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
            $0.top.equalToSuperview().inset(21)
            $0.height.equalTo(25)
        }
        
        bottomSheetTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetTitle.snp.bottom).offset(20)
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
            return impressionTagDummyData.count
        case feelTagCV:
            return feelTagDummyData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteTagCVC.className, for: indexPath) as! WriteTagCVC
        switch collectionView {
        case impressionTagCV:
            cell.setData(data: impressionTagDummyData[indexPath.row])
            return cell
        case feelTagCV:
            cell.setData(data: feelTagDummyData[indexPath.row])
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
            sizingCell.setData(data: impressionTagDummyData[indexPath.row])
        case feelTagCV:
            sizingCell.setData(data: feelTagDummyData[indexPath.row])
        default: break
        }
        
        sizingCell.contentLabel.sizeToFit()
        
        let cellWidth = sizingCell.contentLabel.frame.width + 26
        let cellHeight = tagCellHeight
        return CGSize(width: cellWidth, height: CGFloat(cellHeight))
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

// MARK: - BottomSheetTagView
extension StorageBottomSheet {
    func setCVLayout() {
        containerView.addSubviews([impressionLabel, impressionTagCV, feelLabel, feelTagCV])
    
        impressionLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(45)
            $0.left.equalToSuperview().inset(22)
            $0.height.equalTo(16)
        }
        
        impressionTagCV.snp.makeConstraints {
            $0.top.equalTo(impressionLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(86)
            $0.height.equalTo(tagCellHeight * 2 + cellVerticalSpacing)
        }
        
        feelLabel.snp.makeConstraints {
            $0.top.equalTo(impressionTagCV.snp.bottom).offset(33)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        feelTagCV.snp.makeConstraints {
            $0.top.equalTo(feelLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(19)
            $0.height.equalTo(tagCellHeight * 5 + cellVerticalSpacing * 4)
        }
        
    }
}
