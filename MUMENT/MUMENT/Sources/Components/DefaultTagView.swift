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
        $0.textColor = .mGray1
        $0.backgroundColor = .mGray5
    }

    var tagContent: Int = 0 {
        didSet{
            contentLabel.text = tagContent.tagString()
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
                contentLabel.backgroundColor = .mPurple2
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
//            $0.edges.equalToSuperview()
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(7)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(7)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(5)
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
