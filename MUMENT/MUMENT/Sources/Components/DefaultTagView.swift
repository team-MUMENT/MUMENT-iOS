//
//  DefaultTagListView.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/12.
//
import UIKit
import SnapKit
import Then

class TagView: UIView {
    
    // MARK: - Properties
    private let contentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .mumentB8M12
    }

    var tagContent: Int = 0 {
        didSet{
            contentLabel.text = tagContent.string
        }
    }
    
    var tagContentString: String = ""{
        didSet{
            contentLabel.text = tagContentString
        }
    }
    
    var tagType = "" {
        didSet{
            if tagType == "isFirst" {
                contentLabel.textColor = .mPurple1
                self.backgroundColor = .mPurple2
            }else{
                contentLabel.textColor = .mGray1
                self.backgroundColor = .mGray5
            }
        }
    }

    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI
    private func setLayout() {
        self.addSubviews([contentLabel])
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUI() {
        self.makeRounded(cornerRadius: 20)
    }
    
    // MARK: - Functions
//    func setData(data: String) {
//        contentLabel.text = data
//    }
}
