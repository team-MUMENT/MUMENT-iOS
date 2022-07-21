//
//  Int+.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/19.
//

import Foundation

extension Int {
    func tagString() -> String? {
        if self == 100 {
            return "🎙 음색"
        } else if self == 101 {
            return "🥁 비트"
        } else if self == 102 {
            return "🖋 가사"
        } else if self == 103 {
            return "🎶 멜로디"
        } else if self == 104 {
            return "🎸 베이스"
        } else if self == 105 {
            return "🛫 도입부"
        } else if self == 200 {
            return "🎡 벅참"
        } else if self == 201 {
            return "😄 신남"
        } else if self == 202 {
            return "💐 설렘"
        } else if self == 203 {
            return "😚 행복"
        } else if self == 204 {
            return "🙌 자신감"
        } else if self == 205 {
            return "🍀 여유로움"
        } else if self == 206 {
            return "🍁 센치함"
        } else if self == 207 {
            return "😔 우울"
        } else if self == 208 {
            return "🕰 그리움"
        } else if self == 209 {
            return "🛌 외로움"
        } else if self == 210 {
            return "🌋 스트레스"
        } else if self == 211 {
            return "⌛️ 아련함"
        } else if self == 212 {
            return "💭 회상"
        } else if self == 213 {
            return " 👥 위로"
        } else if self == 214 {
            return "🌅 낭만"
        } else if self == 215 {
            return "☕️ 차분"
        } else {
            return nil
        }
    }
}
