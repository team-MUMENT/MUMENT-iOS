//
//  CarouselTVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/09.
//


import UIKit
import SnapKit
import Then

class CarouselTVC: UITableViewCell {
    
    // MARK: - Properties
    var dataSource: [CarouselModel] = CarouselModel.sampleData
    private lazy var increasedDataSource: [CarouselModel] = {
        dataSource + dataSource + dataSource
    }()
    
    private lazy var carouselCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    private let CVFlowLayout = UICollectionViewFlowLayout()
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCV()
        setLayout()
        carouselCV.scrollToItem(at: IndexPath(item: increasedDataSource.count / 3,section: 0),
                                at: .centeredHorizontally,
                                animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setCV() {
        carouselCV.delegate = self
        carouselCV.dataSource = self
        carouselCV.register(CarouselCVC.self, forCellWithReuseIdentifier: CarouselCVC.className)
        
        //ScrollIndicator 안 보이게
        carouselCV.showsHorizontalScrollIndicator = false
        
        // 그냥 슬라이딩이 아니라 페이지별로 나뉘어 넘어가지도록
        carouselCV.isPagingEnabled = true
        
        // 수평 스크롤
        CVFlowLayout.scrollDirection = .horizontal
    }
}

// MARK: - UI
extension CarouselTVC {
    
    private func setLayout() {
        self.addSubviews([carouselCV])
        
        backgroundColor = .systemBlue
        selectionStyle = .none
        carouselCV.snp.makeConstraints{
            $0.center.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CarouselTVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let beginOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount)
        let endOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
        
        if scrollView.contentOffset.x < beginOffset && velocity.x < .zero {
            scrollToEnd = true
        } else if scrollView.contentOffset.x > endOffset && velocity.x > .zero {
            scrollToBegin = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollToBegin {
            carouselCV.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: .zero),
                                    at: .centeredHorizontally,
                                    animated: false)
            scrollToBegin.toggle()
            return
        }
        if scrollToEnd {
            carouselCV.scrollToItem(at: IndexPath(item: originalDataSourceCount * 2 - 1, section: .zero),
                                    at: .centeredHorizontally,
                                    animated: false)
            scrollToEnd.toggle()
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCVC.className, for: indexPath)
        if let cell = cell as? CarouselCVC {
            cell.setData(increasedDataSource[indexPath.row],index:indexPath.row%3+1)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CarouselTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
