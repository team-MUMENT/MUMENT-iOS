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
    var nowPage: Int = 3
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
        DispatchQueue.main.async {
            self.carouselCV.scrollToItem(at: IndexPath(item: self.originalDataSourceCount,section: .zero),
                                         at: .centeredHorizontally,
                                         animated: false)
        }
        bannerTimer()
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
        
        carouselCV.showsHorizontalScrollIndicator = false
        carouselCV.isPagingEnabled = false
        carouselCV.decelerationRate = .fast
        
        CVFlowLayout.scrollDirection = .horizontal
        CVFlowLayout.itemSize = CGSize(width: 335, height: 257)
        CVFlowLayout.minimumInteritemSpacing = 10
    }
    
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
//        if nowPage == increasedDataSource.count-1 {
//            // 맨 처음 페이지로 돌아감
//            carouselCV.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
//            nowPage = 0
//            return
//        }
        // 다음 페이지로 전환
//        nowPage = Int(carouselCV.contentOffset.x) / Int(carouselCV.frame.width)
        nowPage += 1
        carouselCV.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
        let beginOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount)
        let endOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
        
        print(carouselCV.contentOffset.x )
        if carouselCV.contentOffset.x < beginOffset{
            scrollToEnd = true
        } else if carouselCV.contentOffset.x > endOffset {
            scrollToBegin = true
        }
        
//        let cellWidthIncludingSpacing = CVFlowLayout.itemSize.width + CVFlowLayout.minimumLineSpacing
//        let constantForCentering = carouselCV.frame.width - cellWidthIncludingSpacing - CVFlowLayout.minimumLineSpacing
//
//        let estimatedIndex = carouselCV.contentOffset.x / cellWidthIncludingSpacing
//        let index = Int(ceil(estimatedIndex))
//        } else if velocity.x < 0 {
//            index = Int(floor(estimatedIndex))
//        } else {
//            index = Int(round(estimatedIndex))
//        }
        
//        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - constantForCentering, y: 0)
        
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
}

// MARK: - UI
extension CarouselTVC {
    
    private func setLayout() {
        self.addSubviews([carouselCV])
        
        selectionStyle = .none
        carouselCV.snp.makeConstraints{
            $0.center.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension CarouselTVC: UICollectionViewDelegate{
    
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
        
        let cellWidthIncludingSpacing = CVFlowLayout.itemSize.width + CVFlowLayout.minimumLineSpacing
        let constantForCentering = carouselCV.frame.width - cellWidthIncludingSpacing - CVFlowLayout.minimumLineSpacing
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        nowPage = index
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - constantForCentering, y: 0)
        
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
    
}

// MARK: - UICollectionViewDataSource
extension CarouselTVC: UICollectionViewDataSource {
    
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
