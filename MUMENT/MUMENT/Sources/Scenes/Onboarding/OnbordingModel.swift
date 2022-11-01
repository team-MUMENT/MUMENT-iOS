//
//  OnbordingModel.swift
//  MUMENT
//
//  Created by 김지민 on 2022/11/01.
//

import UIKit

struct OnboardingModel {
    let phrase: String
    let backgroundImageTitle:String
    var backgroundImage: UIImage? {
        return UIImage(named:backgroundImageTitle)
    }
}

// MARK: - Extensions
extension OnboardingModel {
    static var onboardingData: [OnboardingModel] = [
        OnboardingModel(phrase:"음악 감상을\n손쉽게 기록해요!", backgroundImageTitle:"onboarding1"),
        OnboardingModel(phrase:"다양한 감상을\n발견해요!", backgroundImageTitle:"onboarding2"),
        OnboardingModel(phrase:"나만의 추억을\n꺼내 봐요!", backgroundImageTitle:"onboarding3")
    ]
}

