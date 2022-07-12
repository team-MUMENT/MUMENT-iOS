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
        $0.backgroundColor = .lightGray
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
        $0.titleLabel?.font = .mumentB4B14
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
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setRadioButtonSelectStatus(button: firstTimeButton, isSelected: false)
        setRadioButtonSelectStatus(button: alreadyKnowButton, isSelected: true)
        setRadioButton()
    }
    
    // MARK: - Functions
    private func setRadioButton() {
        firstTimeButton.press {
            print("asdf")
            self.setRadioButtonSelectStatus(button: self.firstTimeButton, isSelected: true)
            self.setRadioButtonSelectStatus(button: self.alreadyKnowButton, isSelected: false)
        }
        alreadyKnowButton.press {
            self.setRadioButtonSelectStatus(button: self.firstTimeButton, isSelected: false)
            self.setRadioButtonSelectStatus(button: self.alreadyKnowButton, isSelected: true)
        }
    }
}

// MARK: - UI
extension WriteVC {
    
    private func setRadioButtonSelectStatus(button: UIButton, isSelected: Bool) {
        button.isSelected = isSelected
        button.titleLabel?.font = isSelected ? .mumentB3B14 : .mumentB4M14
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
        }
    }
}
