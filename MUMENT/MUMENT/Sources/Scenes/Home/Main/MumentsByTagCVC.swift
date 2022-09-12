
//
//  MumentsByTagCVC.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/14.
//
import UIKit
import SnapKit
import Then

protocol MumentsByTagCVCDelegate : AnyObject{
    func mumentsByTagCVCSelected(data: MumentsByTagResponseModel.MumentList)
    
    // Test Code
    func mumentsByTagCVCSelected()

}

class MumentsByTagCVC: UICollectionViewCell {
    
    // MARK: - Properties
    let mumentsByTagCardView = MumentsByTagCardView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: MumentsByTagResponseModel.MumentList){
        mumentsByTagCardView.setData(cellData)
    }
    
    // Test Code
    func setData(_ cellData: MumentsByTagModel){
        mumentsByTagCardView.setData(cellData)
    }
    
}

// MARK: - UI
extension MumentsByTagCVC {
    private func setUI(){
        
    }
    
    private func setLayout() {
        self.addSubviews([mumentsByTagCardView])
        
        mumentsByTagCardView.snp.makeConstraints{
//            $0.edges.equalTo(self.safeAreaLayoutGuide)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.right.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

