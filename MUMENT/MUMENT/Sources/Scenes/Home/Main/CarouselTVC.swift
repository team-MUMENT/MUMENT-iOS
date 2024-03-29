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
    
    private var nowPage: Int = 3
    
    private var index: Int = 0
    
    var carouselData: [CarouselResponseModel.BannerList] = [CarouselResponseModel.BannerList(music: CarouselResponseModel.BannerList.Music(id: "", name: "", artist: "", image: APIConstants.defaultProfileImageURL), tagTitle: "", displayDate: "")]
    
    private var increasedCarouselData: [CarouselResponseModel.BannerList] = []
    
    private lazy var carouselCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    private let CVFlowLayout = UICollectionViewFlowLayout()
    
    private var timer: Timer?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCV()
        setLayout()
        setNotificationCenter()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeNotificationCenter()
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
    
    private func setScrollToFirst() {
        nowPage = self.carouselData.count
        DispatchQueue.main.async {
            self.carouselCV.scrollToItem(at: IndexPath(item: self.nowPage, section: .zero),
                                         at: .centeredHorizontally,
                                         animated: false)
        }
    }
    
    private func bannerTimer() {
        //기존에 타이머 동작중이면 중지 처리
        if timer != nil && timer!.isValid {
            if let bannerTimer = timer {
                bannerTimer.invalidate()
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.timer?.tolerance = 0.3
            self.bannerMove()
        }
        
        /// 현재 RunLoop에 timer를 common mode로 추가 함으로써 스크롤 시에도 타이머 작동 하도록 함
        DispatchQueue.main.async {
            RunLoop.current.add(self.timer ?? Timer(), forMode: .common)
        }
    }
    
    private func bannerTimerInvalidate() {
        self.timer?.invalidate()
    }
    
    private func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == 6 {
            // 맨 처음 페이지로 돌아감
            nowPage = 3
            carouselCV.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath,
                                    at: .centeredHorizontally,
                                    animated: false)
        }
        /// 오른쪽 끝에서 타이머가 시작될 경우
        if nowPage >= 8 {
            nowPage = 2
            carouselCV.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath,
                                    at: .centeredHorizontally,
                                    animated: false)
        }
        // 다음 페이지로 전환
        nowPage += 1
        carouselCV.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath,
                                at: .centeredHorizontally,
                                animated: true)
    }
    
    func setData(_ cellData: CarouselResponseModel) {
        carouselData = cellData.bannerList
        setIncreasedCarouselData()
        carouselCV.reloadData()
    }
    
    private func setIncreasedCarouselData() {
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
        self.delegate?.carouselCVCSelected(data: increasedCarouselData[indexPath.row])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        /// dragging 시 타이머 종료
        timer?.invalidate()
        
        /// 빠른 드래깅으로 index가 양쪽 끝으로 갔을때 다른 index로 바꿔치기
        if index <= 0 {
            index = 6
            nowPage = index
            self.carouselCV.scrollToItem(at: NSIndexPath(item: self.nowPage, section: 0) as IndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
        }
        if index >= 8 {
            index = 2
            nowPage = index
            self.carouselCV.scrollToItem(at: NSIndexPath(item: self.nowPage, section: 0) as IndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
        }
        
        let beginOffset = (carouselCV.frame.width - CVFlowLayout.minimumLineSpacing) * 2
        let endOffset = (carouselCV.frame.width - CVFlowLayout.minimumLineSpacing) * 5
        
        if scrollView.contentOffset.x < beginOffset {
            nowPage = 5
            self.carouselCV.scrollToItem(at: NSIndexPath(item: self.nowPage, section: 0) as IndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
        } else if scrollView.contentOffset.x > endOffset {
            nowPage = 3
            self.carouselCV.scrollToItem(at: NSIndexPath(item: self.nowPage, section: 0) as IndexPath,
                                         at: .centeredHorizontally,
                                         animated: false)
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = CVFlowLayout.itemSize.width + CVFlowLayout.minimumLineSpacing
        let constantForCentering = (carouselCV.frame.width - CVFlowLayout.itemSize.width)/2
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - constantForCentering, y: 0)
        nowPage = index
        /// 드래깅 종료시 타이머 다시 실행
        bannerTimer()
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
// MARK: - NotificationCenter
extension CarouselTVC {
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setTimer(_:)), name: .sendViewState, object: nil)
    }
    
    @objc func setTimer(_ notification: Notification){
        setScrollToFirst()
        if let shouldTimerEnable = notification.object as? Bool {
            if shouldTimerEnable {
                bannerTimer()
            }else {
                bannerTimerInvalidate()
            }
        }
    }
    
    private func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: .sendViewState, object: nil)
    }
}
