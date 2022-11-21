//
//  OnbordingModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit

struct OnboardingModel {
    let heading: String
    let highlightedHeading: String
    let subHeading: String
    let backgroundImageTitle: String
    var backgroundImage: UIImage? {
        return UIImage(named:backgroundImageTitle)
    }
}

// MARK: - Extensions
extension OnboardingModel {
    static var onboardingData: [OnboardingModel] = [
        OnboardingModel(heading:"음악 감상을 손쉽게 기록해요!", highlightedHeading: "손쉽게 기록해요!", subHeading:"감상태그를 이용해 감정과\n인상적인 부분을 남겨보세요.", backgroundImageTitle:"onboarding1"),
        OnboardingModel(heading:"다양한 감상을 발견해요!", highlightedHeading: "발견해요!", subHeading:"노래에 담긴 다채로운 이야기를\n검색 또는 추천을 통해 만나보세요.", backgroundImageTitle:"onboarding2"),
        OnboardingModel(heading:"나만의 추억을 꺼내 봐요!", highlightedHeading: "꺼내 봐요!", subHeading:"내가 쌓은 감상과 인상 깊었던\n뮤멘트를 보관함에서 모아보세요.", backgroundImageTitle:"onboarding3")
    ]
}

