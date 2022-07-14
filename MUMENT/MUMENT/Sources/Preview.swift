//
//  Preview.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/14.
//


// MARK: - SwiftUI Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeVC().showPreview(.iPhone13mini)
        WriteVC().showPreview(.iPhone13mini)
        StorageVC().showPreview(.iPhoneSE2)
        HomeVC().showPreview(.iPhoneSE2)
        HomeVC().showPreview(.iPhone8)
        HomeVC().showPreview(.iPhone13Pro)
    }
}
#endif
