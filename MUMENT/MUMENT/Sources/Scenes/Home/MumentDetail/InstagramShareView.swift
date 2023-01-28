//
//  InstagramShareImageRenderer.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/26.
//

import UIKit
import SnapKit
import Then

final class InstagramShareView:
    UIView {
//    UIViewController {
    
    // MARK: - Properties
    private var isFirst: Bool = false
    private var impressionTags: [Int] = []
    private var feelingTags: [Int] = []
    
    // MARK: - Components
    private let mumentCardView: UIView = UIView().then {
        $0.backgroundColor = .mBgwhite
        $0.makeRounded(cornerRadius: 11)
        //        $0.layer.shadowRadius = 4
        //        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        //        $0.layer.shadowColor = UIColor.black.cgColor
        //        $0.layer.shadowOpacity = 0.25
    }
    private let writerProfileImageView: UIImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 12.5)
    }
    private let writerNameLabel: UILabel = UILabel().then {
        $0.textColor = .mBlack2
        $0.font = .mumentC1R12
    }
    private lazy var writerInfoStackView = UIStackView(arrangedSubviews: [writerProfileImageView, writerNameLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 7
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = .mGray4
    }
    private let albumImageView: UIImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 5)
    }
    private let musicTitleLabel: UILabel = UILabel().then {
        $0.textColor = .mBlack2
        $0.font = .mumentB2B14
    }
    private let artistNameLabel: UILabel = UILabel().then {
        $0.textColor = .mGray1
        $0.font = .mumentB6M13
    }
    private let tagStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let tagSubStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let contentsLabel: UILabel = UILabel().then {
        $0.textColor = .mGray1
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 6
        $0.font = .mumentB4M14
    }
    private let createdAtLabel: UILabel = UILabel().then {
        $0.textColor = .mGray2
        $0.font = .mumentC1R12
    }
    private let mumentLogoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "mumentLogo")
    }
    private let testImageView: UIImageView = UIImageView()
    
    //     MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        self.backgroundColor = .clear
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // 뷰가 푸시되어야 시작.
    // MARK: - View Life Cycle
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            setLayout()
//            print("SETLAYOUT")
//        }
    //    convenience init(){
    //        self.init()
    //        setLayout()
    //    }
    
    // This allows you to initialise your custom UIViewController without a nib or bundle.
    //    convenience init() {
    //        self.init(nibName:nil, bundle:nil)
    //    }
    //
    //    // This extends the superclass.
    //    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //        setLayout()
    //    }
    //
    //    // This is also necessary when extending the superclass.
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented") // or see Roman Sausarnes's answer
    //    }
    
    //MARK: - Functions
    func setDummyData(_ data: MumentDetailVCModel) {
        writerProfileImageView.image = data.profileImage
        writerNameLabel.text = data.writerName
        albumImageView.image = data.albumImage
        musicTitleLabel.text = data.songtitle
        artistNameLabel.text = data.artist
        isFirst = data.isFirst
        impressionTags = data.impressionTags
        feelingTags = data.feelingTags
        contentsLabel.text = data.contents.replaceNewLineKeyword()
        createdAtLabel.text = data.createdAt
        
        setTags()
    }
    
    private func setTags(){
        
        tagStackView.removeAllArrangedSubviews()
        tagSubStackView.removeAllArrangedSubviews()
        
        let tag = TagView()
        tag.tagType = "isFirst"
        tag.tagContentString = isFirst ? "처음" : "다시"
        tagStackView.addArrangedSubview(tag)
        
        if impressionTags.count != 0 {
            for i in 0...impressionTags.count-1 {
                let tag = TagView()
                tag.tagContent = impressionTags[i]
                
                if  tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                }else{
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
        
        if feelingTags.count != 0 {
            for i in 0...feelingTags.count-1 {
                let tag = TagView()
                tag.tagContent = feelingTags[i]
                
                if  tagStackView.subviews.count < 4 {
                    tagStackView.addArrangedSubview(tag)
                } else {
                    tagSubStackView.addArrangedSubview(tag)
                }
            }
        }
    }
    
    func renderImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: mumentCardView.bounds)
//        let renderedImage = renderer.image { _ in
//            mumentCardView.layer.render(in: rendererContext.cgContext)
//            mumentCardView.drawHierarchy(in: mumentCardView.bounds, afterScreenUpdates: true)
//        }
        //        return mumentCardView.asImage()
        //        let renderedImage = mumentCardView.asImage()
//                print("RENDERIMAGEFUNC", renderedImage.size)
        //        return renderedImage
        
        

//        let renderer = UIGraphicsImageRenderer(size: bounds.size)
//        print("mumentCardView.frame.size",bounds.size)
//        let image = renderer.image { ctx in
//            mumentCardView.drawHierarchy(in: bounds, afterScreenUpdates: true)
//        }
        
        let renderer = UIGraphicsImageRenderer(bounds: mumentCardView.bounds)
        print("mumentCardView.frame.size",mumentCardView.bounds)
                return renderer.image { rendererContext in
                    self.layer.render(in: rendererContext.cgContext)
                }
//        return image
    }
}

// MARK: - UI
extension InstagramShareView {
    
    private func setLayout() {
//        self.backgroundColor = .mPurple1
        self.addSubviews([mumentCardView])
        mumentCardView.addSubviews([writerInfoStackView, separatorView, albumImageView, musicTitleLabel, artistNameLabel, tagStackView, tagSubStackView, contentsLabel, createdAtLabel, mumentLogoImageView])
        
        mumentCardView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(87)
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(42)
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(42)
        }
        writerInfoStackView.snp.makeConstraints {
            $0.top.equalTo(mumentCardView.snp.top).offset(12)
            $0.left.equalToSuperview().offset(13)
        }
        separatorView.snp.makeConstraints {
            $0.top.equalTo(writerInfoStackView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().inset(13)
            $0.height.equalTo(1)
        }
        albumImageView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(159)
        }
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(artistNameLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        tagSubStackView.snp.makeConstraints {
            $0.top.equalTo(tagStackView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(tagStackView.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().inset(13)
        }
        createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().inset(17)
        }
        mumentLogoImageView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(30)
            $0.right.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(17)
            $0.width.equalTo(81)
            $0.height.equalTo(19)
        }
        
        writerProfileImageView.snp.makeConstraints {
            $0.width.height.equalTo(25)
        }
        //
        //        testImageView.snp.makeConstraints {
        //            $0.centerX.equalToSuperview()
        //            $0.centerY.equalToSuperview()
        //        }
    }
}
