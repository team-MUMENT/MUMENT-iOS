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
            return "π μμ"
        } else if self == 101 {
            return "π₯ λΉνΈ"
        } else if self == 102 {
            return "π κ°μ¬"
        } else if self == 103 {
            return "πΆ λ©λ‘λ"
        } else if self == 104 {
            return "πΈ λ² μ΄μ€"
        } else if self == 105 {
            return "π« λμλΆ"
        } else if self == 200 {
            return "π‘ λ²μ°Έ"
        } else if self == 201 {
            return "π μ λ¨"
        } else if self == 202 {
            return "π μ€λ "
        } else if self == 203 {
            return "π νλ³΅"
        } else if self == 204 {
            return "π μμ κ°"
        } else if self == 205 {
            return "π μ¬μ λ‘μ"
        } else if self == 206 {
            return "π μΌμΉν¨"
        } else if self == 207 {
            return "π μ°μΈ"
        } else if self == 208 {
            return "π° κ·Έλ¦¬μ"
        } else if self == 209 {
            return "π μΈλ‘μ"
        } else if self == 210 {
            return "π μ€νΈλ μ€"
        } else if self == 211 {
            return "βοΈ μλ ¨ν¨"
        } else if self == 212 {
            return "π­ νμ"
        } else if self == 213 {
            return " π₯ μλ‘"
        } else if self == 214 {
            return "π λ­λ§"
        } else if self == 215 {
            return "βοΈ μ°¨λΆ"
        } else {
            return nil
        }
    }
}
