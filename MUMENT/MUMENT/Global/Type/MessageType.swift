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
    case unabledMailApp
    case completedSendContactMail
    case failedSendContactMail
    case reportAlreadyBlockedUser
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
            
        case .unabledMailApp:
            return "Mail 앱을 사용할 수 없습니다. 기기에 Mail 앱이 설치되어 있는지 확인해 주세요."
            
        case .completedSendContactMail:
            return "문의 메일 전송이 완료되었습니다."
            
        case .failedSendContactMail:
            return "메일 전송에 실패하였습니다. 다시 시도해 주세요."
            
        case .reportAlreadyBlockedUser:
            return "이미 차단된 유저입니다.\n신고가 정상적으로 접수되었습니다."
        }
    }
}
