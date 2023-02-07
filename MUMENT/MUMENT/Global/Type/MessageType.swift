//
//  MessageType.swift
//  MUMENT
//
//  Created by madilyn on 2022/10/31.
//

import Foundation

enum MessageType {
    case networkError
    case modelErrorForDebug
    case reportUserBlockError
}

extension MessageType {
    var message: String {
        switch self {
        case .networkError:
            return """
네트워크 오류로 인해 연결에 실패했어요! 🥲
잠시 후에 다시 시도해 주세요.
"""
        case .modelErrorForDebug:
            return "🚨당신 모델이 이상해열~🚨"
            
        case .reportUserBlockError:
            return "신고가 정상적으로 완료되었으나,\n일시적인 네트워크 오류로 인해 차단을 실패했습니다.\n\n잠시 후 다시 시도해주시기 바랍니다."
        }
    }
}
