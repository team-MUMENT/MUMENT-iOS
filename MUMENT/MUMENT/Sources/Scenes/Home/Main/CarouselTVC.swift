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
    var carouselData: [CarouselResponseModel.BannerList] = [CarouselResponseModel.BannerList(music: CarouselResponseModel.BannerList.Music(id: "", name: "", artist: "", image: "https://avatars.githubusercontent.com/u/25932970?s=88&u=9ceb91d683a7d9cfe968cd35cd07a428536605e6&v=4"), id: "", tagTitle: "", displayDate: "")]
        
    private var increasedCarouselData: [CarouselResponseModel.BannerList] = []
    
    private lazy var carouselCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    private let CVFlowLayout = UICollectionViewFlowLayout()
    private var originalDataSourceCount: Int {
        carouselData.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
//    let beginOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount)
//    let endOffset = carouselCV.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
//
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
//        bannerTimer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setCV() {
        setIncreasedCarouselData()
        carouselCV.delegate = self
        carouselCV.dataSource = self
        carouselCV.register(CarouselCVC.self, forCellWithReuseIdentifier: CarouselCVC.className)
        
        carouselCV.showsHorizontalScrollIndicator = false
        carouselCV.isPagingEnabled = false
        carouselCV.decelerationRate = .fast
        
        CVFlowLayout.scrollDirection = .horizontal
        CVFlowLayout.itemSize = CGSize(width: 335, height: 257)
        CVFlowLayout.minimumInteritemSpacing = 10
        
        carouselCV.backgroundColor = .mBgwhite
        self.backgroundColor = .mBgwhite
    }
    
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage%3 == 0 {
            // 맨 처음 페이지로 돌아감
            carouselCV.scrollToItem(at: NSIndexPath(item: 3, section: 0) as IndexPath, at: .right, animated: false)
            nowPage = 3
            
        }
        
        // 다음 페이지로 전환
//        nowPage = Int(carouselCV.contentOffset.x) / Int(carouselCV.frame.width)
        nowPage += 1
        carouselCV.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func setData(_ cellData: CarouselResponseModel) {
        carouselData = cellData.bannerList
        setIncreasedCarouselData()
        carouselCV.reloadData()
    }
    
    func setIncreasedCarouselData() {
        increasedCarouselData = carouselData + carouselData + carouselData
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
        let constantForCentering = (carouselCV.frame.width - CVFlowLayout.itemSize.width)/2
        
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
//        nowAdsPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)

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
        return increasedCarouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCVC.className, for: indexPath)
        if let cell = cell as? CarouselCVC {
            cell.setData(increasedCarouselData[indexPath.row],index:indexPath.row%3+1)
        }
        
        return cell
    }
}
