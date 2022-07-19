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
    weak var delegate: CarouselCVCDelegate?
    
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
        DispatchQueue.main.async {
            self.carouselCV.scrollToItem(at: IndexPath(item: self.originalDataSourceCount,section: .zero),
                                         at: .centeredHorizontally,
                                         animated: false)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CarouselCVC {
            cell.isSelected = true
        }
        self.delegate?.carouselCVCSelected()
    }
    
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
