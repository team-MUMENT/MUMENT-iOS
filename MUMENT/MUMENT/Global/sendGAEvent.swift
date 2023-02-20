//
//  sendGAEvent.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/20.
//

import Foundation
import FirebaseAnalytics

func sendGAEvent(eventName: GAEventNameType, parameterValue: GAEventNameType.ParameterValue) {
    let parameters = [eventName.parameterKey: "\(parameterValue)"]
    print(("\(eventName)", parameters: parameters))
    FirebaseAnalytics.Analytics.logEvent("\(eventName)", parameters: parameters)
}
